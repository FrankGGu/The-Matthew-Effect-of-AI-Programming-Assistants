/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     struct ListNode *next;
 * };
 */
struct ListNode* modifiedList(int* nums, int numsSize, struct ListNode* head) {
    int hash[100001] = {0};
    for (int i = 0; i < numsSize; i++) {
        hash[nums[i]] = 1;
    }

    while (head && hash[head->val]) {
        head = head->next;
    }

    if (!head) return NULL;

    struct ListNode* curr = head;
    while (curr->next) {
        if (hash[curr->next->val]) {
            curr->next = curr->next->next;
        } else {
            curr = curr->next;
        }
    }

    return head;
}