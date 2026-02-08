class Solution {
public:
    ListNode* deleteNodes(ListNode* head, vector<int>& nums) {
        unordered_set<int> toDelete(nums.begin(), nums.end());
        ListNode dummy(0);
        dummy.next = head;
        ListNode* prev = &dummy;
        ListNode* curr = head;

        while (curr != nullptr) {
            if (toDelete.find(curr->val) != toDelete.end()) {
                prev->next = curr->next;
                curr = curr->next;
            } else {
                prev = curr;
                curr = curr->next;
            }
        }

        return dummy.next;
    }
};