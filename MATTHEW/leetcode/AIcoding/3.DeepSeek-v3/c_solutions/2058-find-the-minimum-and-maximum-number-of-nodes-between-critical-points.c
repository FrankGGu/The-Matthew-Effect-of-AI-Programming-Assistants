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
int* nodesBetweenCriticalPoints(struct ListNode* head, int* returnSize) {
    *returnSize = 2;
    int* result = malloc(2 * sizeof(int));
    result[0] = -1;
    result[1] = -1;

    if (!head || !head->next || !head->next->next) {
        return result;
    }

    struct ListNode* prev = head;
    struct ListNode* curr = head->next;
    struct ListNode* next = curr->next;

    int firstIndex = -1;
    int lastIndex = -1;
    int prevIndex = -1;
    int minDistance = INT_MAX;
    int index = 1;

    while (next) {
        if ((curr->val > prev->val && curr->val > next->val) || 
            (curr->val < prev->val && curr->val < next->val)) {

            if (firstIndex == -1) {
                firstIndex = index;
            } else {
                minDistance = fmin(minDistance, index - prevIndex);
            }

            lastIndex = index;
            prevIndex = index;
        }

        prev = curr;
        curr = next;
        next = next->next;
        index++;
    }

    if (firstIndex == -1 || lastIndex == firstIndex) {
        return result;
    }

    result[0] = minDistance;
    result[1] = lastIndex - firstIndex;

    return result;
}