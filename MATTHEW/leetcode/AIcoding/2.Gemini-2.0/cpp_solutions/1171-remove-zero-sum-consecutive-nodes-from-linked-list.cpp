class Solution {
public:
    ListNode* removeZeroSumSublists(ListNode* head) {
        ListNode* dummy = new ListNode(0);
        dummy->next = head;
        unordered_map<int, ListNode*> prefixSumMap;
        prefixSumMap[0] = dummy;
        int prefixSum = 0;
        ListNode* curr = head;
        while (curr) {
            prefixSum += curr->val;
            if (prefixSumMap.count(prefixSum)) {
                ListNode* prev = prefixSumMap[prefixSum];
                int sum = prefixSum;
                ListNode* temp = prev->next;
                while (temp != curr) {
                    sum += temp->val;
                    prefixSumMap.erase(sum);
                    temp = temp->next;
                }
                prev->next = curr->next;
                prefixSumMap[prefixSum] = prev;
            } else {
                prefixSumMap[prefixSum] = curr;
            }
            curr = curr->next;
        }
        return dummy->next;
    }
};