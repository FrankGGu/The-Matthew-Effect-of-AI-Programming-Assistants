class Solution {
public:
    ListNode* removeZeroSumSublists(ListNode* head) {
        ListNode* dummy = new ListNode(0);
        dummy->next = head;
        unordered_map<int, ListNode*> prefixSum;
        prefixSum[0] = dummy;
        int sum = 0;

        for (ListNode* node = head; node != nullptr; node = node->next) {
            sum += node->val;
            prefixSum[sum] = node;
        }

        sum = 0;
        for (ListNode* node = dummy; node != nullptr; node = node->next) {
            sum += node->val;
            node->next = prefixSum[sum]->next;
        }

        return dummy->next;
    }
};