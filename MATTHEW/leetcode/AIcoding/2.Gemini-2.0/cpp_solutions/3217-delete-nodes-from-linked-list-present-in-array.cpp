class Solution {
public:
    ListNode* deleteNodes(ListNode* head, vector<int>& val) {
        unordered_set<int> toDelete(val.begin(), val.end());
        ListNode* dummy = new ListNode(0);
        dummy->next = head;
        ListNode* curr = dummy;

        while (curr->next != nullptr) {
            if (toDelete.count(curr->next->val)) {
                curr->next = curr->next->next;
            } else {
                curr = curr->next;
            }
        }

        return dummy->next;
    }
};