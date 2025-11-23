#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* word;
    int len;
} WordNode;

int compare(const void* a, const void* b) {
    WordNode* wa = (WordNode*)a;
    WordNode* wb = (WordNode*)b;
    return wb->len - wa->len;
}

int minimumLengthEncoding(char** words, int wordsSize) {
    WordNode* nodes = (WordNode*)malloc(wordsSize * sizeof(WordNode));
    for (int i = 0; i < wordsSize; i++) {
        nodes[i].word = words[i];
        nodes[i].len = strlen(words[i]);
    }

    qsort(nodes, wordsSize, sizeof(WordNode), compare);

    int result = 0;
    int count = 0;

    for (int i = 0; i < wordsSize; i++) {
        int isSuffix = 0;
        for (int j = 0; j < i; j++) {
            int len = nodes[j].len;
            if (len <= nodes[i].len && strcmp(nodes[i].word + nodes[i].len - len, nodes[j].word) == 0) {
                isSuffix = 1;
                break;
            }
        }
        if (!isSuffix) {
            result += nodes[i].len + 1;
            count++;
        }
    }

    free(nodes);
    return result;
}