#include <stdio.h>
#include <stdlib.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int *highFive(struct ListNode *root, int *returnSize) {
    int *result = (int *)malloc(5 * sizeof(int));
    int index = 0;
    int count[1000] = {0};
    int sum[1000] = {0};

    while (root != NULL) {
        sum[root->id] += root->score;
        count[root->id]++;
        root = root->next;
    }

    for (int i = 0; i < 1000; i++) {
        if (count[i] > 0) {
            result[index++] = sum[i] / count[i];
        }
    }

    *returnSize = index;
    return result;
}