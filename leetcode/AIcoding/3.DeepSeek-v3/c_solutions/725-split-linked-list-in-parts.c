/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     struct ListNode *next;
 * };
 */
/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
struct ListNode** splitListToParts(struct ListNode* head, int k, int* returnSize) {
    struct ListNode** result = (struct ListNode**)malloc(k * sizeof(struct ListNode*));
    *returnSize = k;

    int length = 0;
    struct ListNode* curr = head;
    while (curr) {
        length++;
        curr = curr->next;
    }

    int base_size = length / k;
    int extra = length % k;

    curr = head;
    for (int i = 0; i < k; i++) {
        result[i] = curr;

        int part_size = base_size + (i < extra ? 1 : 0);

        for (int j = 0; j < part_size - 1; j++) {
            if (curr) curr = curr->next;
        }

        if (curr) {
            struct ListNode* next = curr->next;
            curr->next = NULL;
            curr = next;
        }
    }

    return result;
}