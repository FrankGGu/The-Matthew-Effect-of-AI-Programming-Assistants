#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_LEN 21
#define ALPHABET_SIZE 26

char *alienOrder(char **words, int wordsSize) {
    int inDegree[ALPHABET_SIZE] = {0};
    bool adjMatrix[ALPHABET_SIZE][ALPHABET_SIZE] = {{false}};
    bool present[ALPHABET_SIZE] = {false};
    int totalChars = 0;

    for (int i = 0; i < wordsSize; i++) {
        for (int j = 0; words[i][j] != '\0'; j++) {
            if (!present[words[i][j] - 'a']) {
                present[words[i][j] - 'a'] = true;
                totalChars++;
            }
        }
    }

    for (int i = 0; i < wordsSize - 1; i++) {
        int len1 = strlen(words[i]);
        int len2 = strlen(words[i + 1]);
        int minLen = (len1 < len2) ? len1 : len2;

        for (int j = 0; j < minLen; j++) {
            if (words[i][j] != words[i + 1][j]) {
                int u = words[i][j] - 'a';
                int v = words[i + 1][j] - 'a';
                if (!adjMatrix[u][v]) {
                    adjMatrix[u][v] = true;
                    inDegree[v]++;
                }
                break;
            }

            if (j == minLen - 1 && len1 > len2) {
                return "";
            }
        }
    }

    char *result = (char *)malloc((totalChars + 1) * sizeof(char));
    int resultIndex = 0;
    int queue[ALPHABET_SIZE];
    int front = 0, rear = 0;

    for (int i = 0; i < ALPHABET_SIZE; i++) {
        if (present[i] && inDegree[i] == 0) {
            queue[rear++] = i;
        }
    }

    while (front < rear) {
        int u = queue[front++];
        result[resultIndex++] = (char)(u + 'a');

        for (int v = 0; v < ALPHABET_SIZE; v++) {
            if (adjMatrix[u][v]) {
                inDegree[v]--;
                if (inDegree[v] == 0) {
                    queue[rear++] = v;
                }
            }
        }
    }

    if (resultIndex != totalChars) {
        free(result);
        return "";
    }

    result[resultIndex] = '\0';
    return result;
}