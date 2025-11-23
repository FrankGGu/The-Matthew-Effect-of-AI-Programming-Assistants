/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the return arrays are returned as *returnColumnSizes.
 */
typedef struct {
    char **words;
    int size;
} WordList;

typedef struct {
    char *word;
    int index;
    int level;
    WordList *path;
} Node;

typedef struct {
    Node **nodes;
    int front;
    int rear;
    int size;
} Queue;

Queue* createQueue(int size) {
    Queue *q = (Queue*)malloc(sizeof(Queue));
    q->nodes = (Node**)malloc(sizeof(Node*) * size);
    q->front = 0;
    q->rear = 0;
    q->size = size;
    return q;
}

void enqueue(Queue *q, Node *node) {
    q->nodes[q->rear++] = node;
}

Node* dequeue(Queue *q) {
    return q->nodes[q->front++];
}

int isEmpty(Queue *q) {
    return q->front == q->rear;
}

WordList* createWordList() {
    WordList *wl = (WordList*)malloc(sizeof(WordList));
    wl->words = NULL;
    wl->size = 0;
    return wl;
}

void addToWordList(WordList *wl, char *word) {
    wl->words = (char**)realloc(wl->words, sizeof(char*) * (wl->size + 1));
    wl->words[wl->size] = (char*)malloc(strlen(word) + 1);
    strcpy(wl->words[wl->size], word);
    wl->size++;
}

WordList* copyWordList(WordList *src) {
    WordList *dest = createWordList();
    for (int i = 0; i < src->size; i++) {
        addToWordList(dest, src->words[i]);
    }
    return dest;
}

void freeWordList(WordList *wl) {
    for (int i = 0; i < wl->size; i++) {
        free(wl->words[i]);
    }
    free(wl->words);
    free(wl);
}

int canTransform(char *a, char *b) {
    int diff = 0;
    while (*a) {
        if (*a != *b) diff++;
        if (diff > 1) return 0;
        a++;
        b++;
    }
    return diff == 1;
}

char*** findLadders(char *beginWord, char *endWord, char **wordList, int wordListSize, int* returnSize, int** returnColumnSizes) {
    *returnSize = 0;
    *returnColumnSizes = NULL;

    int endIndex = -1;
    for (int i = 0; i < wordListSize; i++) {
        if (strcmp(wordList[i], endWord) == 0) {
            endIndex = i;
            break;
        }
    }
    if (endIndex == -1) return NULL;

    int n = wordListSize;
    Queue *q = createQueue(100000);

    Node *start = (Node*)malloc(sizeof(Node));
    start->word = beginWord;
    start->index = -1;
    start->level = 1;
    start->path = createWordList();
    addToWordList(start->path, beginWord);

    enqueue(q, start);

    int *visited = (int*)calloc(n, sizeof(int));
    int minLevel = INT_MAX;

    char ***result = NULL;
    *returnColumnSizes = NULL;

    while (!isEmpty(q)) {
        Node *current = dequeue(q);

        if (current->level > minLevel) {
            freeWordList(current->path);
            free(current);
            continue;
        }

        if (strcmp(current->word, endWord) == 0) {
            if (current->level <= minLevel) {
                if (current->level < minLevel) {
                    minLevel = current->level;
                    for (int i = 0; i < *returnSize; i++) {
                        free(result[i]);
                    }
                    free(result);
                    free(*returnColumnSizes);
                    *returnSize = 0;
                    result = NULL;
                    *returnColumnSizes = NULL;
                }

                result = (char***)realloc(result, sizeof(char**) * (*returnSize + 1));
                (*returnColumnSizes) = (int*)realloc(*returnColumnSizes, sizeof(int) * (*returnSize + 1));

                result[*returnSize] = (char**)malloc(sizeof(char*) * current->path->size);
                for (int i = 0; i < current->path->size; i++) {
                    result[*returnSize][i] = (char*)malloc(strlen(current->path->words[i]) + 1);
                    strcpy(result[*returnSize][i], current->path->words[i]);
                }
                (*returnColumnSizes)[*returnSize] = current->path->size;
                (*returnSize)++;
            }
            freeWordList(current->path);
            free(current);
            continue;
        }

        for (int i = 0; i < n; i++) {
            if (visited[i] == 0 || visited[i] >= current->level + 1) {
                if (canTransform(current->word, wordList[i])) {
                    visited[i] = current->level + 1;

                    Node *newNode = (Node*)malloc(sizeof(Node));
                    newNode->word = wordList[i];
                    newNode->index = i;
                    newNode->level = current->level + 1;
                    newNode->path = copyWordList(current->path);
                    addToWordList(newNode->path, wordList[i]);

                    enqueue(q, newNode);
                }
            }
        }

        freeWordList(current->path);
        free(current);
    }

    free(visited);
    free(q->nodes);
    free(q);

    return result;
}