/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     struct ListNode *next;
 * };
 */
int numComponents(struct ListNode* head, int* nums, int numsSize) {
    int set[10001] = {0};
    for (int i = 0; i < numsSize; i++) {
        set[nums[i]] = 1;
    }

    int components = 0;
    int inComponent = 0;

    struct ListNode* current = head;
    while (current != NULL) {
        if (set[current->val]) {
            if (!inComponent) {
                components++;
                inComponent = 1;
            }
        } else {
            inComponent = 0;
        }
        current = current->next;
    }

    return components;
}