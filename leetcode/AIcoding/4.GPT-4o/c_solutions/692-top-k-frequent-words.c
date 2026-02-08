#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct Node {
    char* word;
    int count;
};

int cmp(const void* a, const void* b) {
    struct Node* nodeA = (struct Node*)a;
    struct Node* nodeB = (struct Node*)b;
    if (nodeA->count != nodeB->count) 
        return nodeB->count - nodeA->count;
    return strcmp(nodeA->word, nodeB->word);
}

char** topKFrequent(char** words, int wordsSize, int k, int* returnSize) {
    int freq[10000] = {0};
    for (int i = 0; i < wordsSize; i++) {
        freq[words[i][0] - 'a']++;
    }

    struct Node* nodes = malloc(sizeof(struct Node) * 10000);
    int idx = 0;
    for (int i = 0; i < 10000; i++) {
        if (freq[i] > 0) {
            nodes[idx].word = words[i];
            nodes[idx].count = freq[i];
            idx++;
        }
    }

    qsort(nodes, idx, sizeof(struct Node), cmp);

    char** result = malloc(sizeof(char*) * k);
    for (int i = 0; i < k; i++) {
        result[i] = nodes[i].word;
    }

    free(nodes);
    *returnSize = k;
    return result;
}