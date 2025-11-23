typedef struct {
    char* word;
    int step;
} Node;

int ladderLength(char* beginWord, char* endWord, char** wordList, int wordListSize) {
    if (strcmp(beginWord, endWord) == 0) return 1;

    int found = 0;
    for (int i = 0; i < wordListSize; i++) {
        if (strcmp(wordList[i], endWord) == 0) {
            found = 1;
            break;
        }
    }
    if (!found) return 0;

    Node* queue = (Node*)malloc((wordListSize + 1) * sizeof(Node));
    int front = 0, rear = 0;

    queue[rear].word = beginWord;
    queue[rear].step = 1;
    rear++;

    int* visited = (int*)calloc(wordListSize, sizeof(int));

    while (front < rear) {
        Node current = queue[front++];
        char* word = current.word;
        int step = current.step;

        for (int i = 0; i < wordListSize; i++) {
            if (visited[i]) continue;

            char* next = wordList[i];
            int diff = 0;
            for (int j = 0; word[j] != '\0'; j++) {
                if (word[j] != next[j]) diff++;
                if (diff > 1) break;
            }

            if (diff == 1) {
                if (strcmp(next, endWord) == 0) {
                    free(queue);
                    free(visited);
                    return step + 1;
                }

                visited[i] = 1;
                queue[rear].word = next;
                queue[rear].step = step + 1;
                rear++;
            }
        }
    }

    free(queue);
    free(visited);
    return 0;
}