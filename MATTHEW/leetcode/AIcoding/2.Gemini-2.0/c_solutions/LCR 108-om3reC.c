#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_WORD_LEN 10
#define MAX_WORD_COUNT 5000

int ladderLength(char * beginWord, char ** wordList, int wordListSize, char * endWord){
    int begin_len = strlen(beginWord);
    int end_len = strlen(endWord);

    if (begin_len != end_len) return 0;

    int end_index = -1;
    for (int i = 0; i < wordListSize; i++) {
        if (strcmp(wordList[i], endWord) == 0) {
            end_index = i;
            break;
        }
    }

    if (end_index == -1) return 0;

    int *visited = (int *)calloc(wordListSize, sizeof(int));
    int *queue = (int *)malloc((wordListSize + 1) * sizeof(int));
    int head = 0, tail = 0;

    queue[tail++] = -1; 

    int level = 1;
    while (head < tail) {
        int size = tail - head;
        for (int k = 0; k < size; k++) {
            int current_index = queue[head++];
            char *current_word;
            if (current_index == -1) {
                current_word = beginWord;
            } else {
                current_word = wordList[current_index];
            }

            if (strcmp(current_word, endWord) == 0) {
                free(visited);
                free(queue);
                return level;
            }

            for (int i = 0; i < wordListSize; i++) {
                if (visited[i] == 0) {
                    int diff = 0;
                    for (int j = 0; j < begin_len; j++) {
                        if (current_word[j] != wordList[i][j]) {
                            diff++;
                        }
                    }
                    if (diff == 1) {
                        queue[tail++] = i;
                        visited[i] = 1;
                    }
                }
            }
        }
        level++;
    }

    free(visited);
    free(queue);
    return 0;
}