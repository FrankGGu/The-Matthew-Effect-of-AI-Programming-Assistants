#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>

typedef struct {
    char *word;
    int level;
} QueueNode;

typedef struct {
    QueueNode *data;
    int front;
    int rear;
    int size;
    int capacity;
} Queue;

Queue *createQueue(int capacity) {
    Queue *q = (Queue *)malloc(sizeof(Queue));
    q->data = (QueueNode *)malloc(capacity * sizeof(QueueNode));
    q->front = 0;
    q->rear = -1;
    q->size = 0;
    q->capacity = capacity;
    return q;
}

void enqueue(Queue *q, char *word, int level) {
    if (q->size == q->capacity) return;
    q->rear = (q->rear + 1) % q->capacity;
    q->data[q->rear].word = strdup(word);
    q->data[q->rear].level = level;
    q->size++;
}

QueueNode dequeue(Queue *q) {
    QueueNode node = q->data[q->front];
    q->front = (q->front + 1) % q->capacity;
    q->size--;
    return node;
}

int isEmpty(Queue *q) {
    return q->size == 0;
}

void freeQueue(Queue *q) {
    for (int i = 0; i < q->capacity; i++) {
        free(q->data[i].word);
    }
    free(q->data);
    free(q);
}

char **findLadders(char **beginWord, char **endWord, int wordListSize, char **wordList, int *returnSize) {
    int len = strlen(*beginWord);
    int endWordLen = strlen(*endWord);
    if (len != endWordLen) {
        *returnSize = 0;
        return NULL;
    }

    int found = 0;
    for (int i = 0; i < wordListSize; i++) {
        if (strcmp(wordList[i], *endWord) == 0) {
            found = 1;
            break;
        }
    }
    if (!found) {
        *returnSize = 0;
        return NULL;
    }

    int wordCount = wordListSize + 1;
    char **words = (char **)malloc(wordCount * sizeof(char *));
    words[0] = strdup(*beginWord);
    for (int i = 0; i < wordListSize; i++) {
        words[i + 1] = strdup(wordList[i]);
    }

    int *visited = (int *)calloc(wordCount, sizeof(int));
    int *distance = (int *)calloc(wordCount, sizeof(int));
    for (int i = 0; i < wordCount; i++) {
        distance[i] = INT_MAX;
    }

    int beginIndex = 0;
    for (int i = 0; i < wordCount; i++) {
        if (strcmp(words[i], *beginWord) == 0) {
            beginIndex = i;
            break;
        }
    }

    int endIndex = -1;
    for (int i = 0; i < wordCount; i++) {
        if (strcmp(words[i], *endWord) == 0) {
            endIndex = i;
            break;
        }
    }

    for (int i = 0; i < wordCount; i++) {
        visited[i] = 0;
    }

    int queueCapacity = wordCount * 10;
    Queue *q = createQueue(queueCapacity);
    enqueue(q, words[beginIndex], 0);
    visited[beginIndex] = 1;
    distance[beginIndex] = 0;

    while (!isEmpty(q)) {
        QueueNode current = dequeue(q);
        char *currentWord = current.word;
        int currentLevel = current.level;

        for (int i = 0; i < wordCount; i++) {
            if (visited[i]) continue;
            if (strlen(currentWord) != strlen(words[i])) continue;

            int diff = 0;
            for (int j = 0; j < len; j++) {
                if (currentWord[j] != words[i][j]) diff++;
                if (diff > 1) break;
            }

            if (diff == 1) {
                if (distance[i] > currentLevel + 1) {
                    distance[i] = currentLevel + 1;
                    enqueue(q, words[i], currentLevel + 1);
                } else if (distance[i] == currentLevel + 1) {
                    enqueue(q, words[i], currentLevel + 1);
                }
                visited[i] = 1;
            }
        }
        free(currentWord);
    }

    if (distance[endIndex] == INT_MAX) {
        *returnSize = 0;
        return NULL;
    }

    char **result = (char **)malloc(wordCount * sizeof(char *));
    int resultSize = 0;

    char **path = (char **)malloc(wordCount * sizeof(char *));
    int pathSize = 0;

    void dfs(int index, char **path, int *pathSize, char **words, int *distance, int endIndex) {
        path[*pathSize] = strdup(words[index]);
        (*pathSize)++;
        if (index == endIndex) {
            result[resultSize++] = strdup(path[0]);
            for (int i = 1; i < *pathSize; i++) {
                result[resultSize - 1] = realloc(result[resultSize - 1], strlen(result[resultSize - 1]) + strlen(path[i]) + 2);
                strcat(result[resultSize - 1], " ");
                strcat(result[resultSize - 1], path[i]);
            }
            (*pathSize)--;
            return;
        }

        for (int i = 0; i < wordCount; i++) {
            if (i == index) continue;
            if (distance[i] != distance[index] - 1) continue;

            int diff = 0;
            for (int j = 0; j < len; j++) {
                if (words[index][j] != words[i][j]) diff++;
                if (diff > 1) break;
            }

            if (diff == 1) {
                dfs(i, path, pathSize, words, distance, endIndex);
            }
        }
        (*pathSize)--;
    }

    dfs(beginIndex, path, &pathSize, words, distance, endIndex);

    for (int i = 0; i < wordCount; i++) {
        free(words[i]);
    }
    free(words);
    free(visited);
    free(distance);
    freeQueue(q);
    free(path);
    *returnSize = resultSize;
    return result;
}