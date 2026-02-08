typedef struct {
    char* word;
    int step;
} Node;

int ladderLength(char* beginWord, char* endWord, char** wordList, int wordListSize) {
    if (beginWord == NULL || endWord == NULL || wordList == NULL || wordListSize == 0) {
        return 0;
    }

    int endWordExists = 0;
    for (int i = 0; i < wordListSize; i++) {
        if (strcmp(wordList[i], endWord) == 0) {
            endWordExists = 1;
            break;
        }
    }
    if (!endWordExists) {
        return 0;
    }

    int wordLen = strlen(beginWord);

    Node* queue = (Node*)malloc(sizeof(Node) * (wordListSize + 1));
    int front = 0, rear = 0;

    queue[rear].word = beginWord;
    queue[rear].step = 1;
    rear++;

    int* visited = (int*)calloc(wordListSize, sizeof(int));

    while (front < rear) {
        Node current = queue[front++];
        char* currentWord = current.word;
        int currentStep = current.step;

        for (int i = 0; i < wordListSize; i++) {
            if (visited[i]) {
                continue;
            }

            char* dictWord = wordList[i];
            int diff = 0;
            for (int j = 0; j < wordLen; j++) {
                if (currentWord[j] != dictWord[j]) {
                    diff++;
                    if (diff > 1) {
                        break;
                    }
                }
            }

            if (diff == 1) {
                if (strcmp(dictWord, endWord) == 0) {
                    free(queue);
                    free(visited);
                    return currentStep + 1;
                }

                visited[i] = 1;
                queue[rear].word = dictWord;
                queue[rear].step = currentStep + 1;
                rear++;
            }
        }
    }

    free(queue);
    free(visited);
    return 0;
}