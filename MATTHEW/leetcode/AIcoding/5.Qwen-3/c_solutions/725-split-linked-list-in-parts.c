#include <stdio.h>
#include <stdlib.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

struct ListNode** splitListToParts(struct ListNode* root, int k, int* returnSize) {
    int len = 0;
    struct ListNode* curr = root;
    while (curr) {
        len++;
        curr = curr->next;
    }

    int partSize = len / k;
    int remainder = len % k;

    struct ListNode** result = (struct ListNode**)malloc(k * sizeof(struct ListNode*));
    *returnSize = k;

    curr = root;
    for (int i = 0; i < k; i++) {
        result[i] = curr;
        int size = partSize + (i < remainder ? 1 : 0);
        for (int j = 0; j < size - 1 && curr; j++) {
            curr = curr->next;
        }
        if (curr) {
            struct ListNode* next = curr->next;
            curr->next = NULL;
            curr = next;
        }
    }

    return result;
}