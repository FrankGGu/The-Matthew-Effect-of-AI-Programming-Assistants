class Solution {
public:
    ListNode* mergeNodes(ListNode* head) {
        ListNode* dummyHead = new ListNode(0);
        ListNode* currentMerged = dummyHead;
        ListNode* currentOriginal = head->next;

        while (currentOriginal != nullptr) {
            int currentSum = 0;
            while (currentOriginal->val != 0) {
                currentSum += currentOriginal->val;
                currentOriginal = currentOriginal->next;
            }
            currentMerged->next = new ListNode(currentSum);
            currentMerged = currentMerged->next;
            currentOriginal = currentOriginal->next;
        }

        return dummyHead->next;
    }
};