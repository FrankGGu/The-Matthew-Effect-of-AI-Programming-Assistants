#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int ladderLength(char * beginWord, char ** wordList, int wordListSize, char * endWord){
    int beginWordLen = strlen(beginWord);
    int endWordLen = strlen(endWord);

    if (beginWordLen != endWordLen) {
        return 0;
    }

    int endWordIndex = -1;
    for (int i = 0; i < wordListSize; i++) {
        if (strcmp(wordList[i], endWord) == 0) {
            endWordIndex = i;
            break;
        }
    }

    if (endWordIndex == -1) {
        return 0;
    }

    bool *visited = (bool *)malloc(sizeof(bool) * wordListSize);
    for (int i = 0; i < wordListSize; i++) {
        visited[i] = false;
    }

    int *queue = (int *)malloc(sizeof(int) * (wordListSize + 1));
    int head = 0;
    int tail = 0;

    queue[tail++] = -1;

    int level = 1;
    while (head < tail) {
        int qSize = tail - head;
        for (int i = 0; i < qSize; i++) {
            int currIndex = queue[head++];
            char *currWord;
            if (currIndex == -1) {
                currWord = beginWord;
            } else {
                currWord = wordList[currIndex];
            }

            if (strcmp(currWord, endWord) == 0) {
                free(queue);
                free(visited);
                return level;
            }

            for (int j = 0; j < wordListSize; j++) {
                if (!visited[j]) {
                    int diff = 0;
                    for (int k = 0; k < beginWordLen; k++) {
                        if (currWord[k] != wordList[j][k]) {
                            diff++;
                        }
                    }
                    if (diff == 1) {
                        queue[tail++] = j;
                        visited[j] = true;
                    }
                }
            }
        }
        level++;
    }

    free(queue);
    free(visited);
    return 0;
}