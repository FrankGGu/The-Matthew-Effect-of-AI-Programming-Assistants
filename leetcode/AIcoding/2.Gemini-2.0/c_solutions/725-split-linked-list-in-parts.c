#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

struct ListNode **splitListToParts(struct ListNode *head, int k, int *returnSize){
    int len = 0;
    struct ListNode *curr = head;
    while (curr) {
        len++;
        curr = curr->next;
    }

    int base_size = len / k;
    int extra = len % k;

    struct ListNode **result = (struct ListNode **)malloc(sizeof(struct ListNode *) * k);
    *returnSize = k;

    curr = head;
    for (int i = 0; i < k; i++) {
        result[i] = curr;
        int part_size = base_size + (i < extra ? 1 : 0);

        if (curr) {
            for (int j = 1; j < part_size; j++) {
                curr = curr->next;
            }
            if (curr) {
                struct ListNode *temp = curr->next;
                curr->next = NULL;
                curr = temp;
            }
        } else {
            result[i] = NULL;
        }
    }

    return result;
}