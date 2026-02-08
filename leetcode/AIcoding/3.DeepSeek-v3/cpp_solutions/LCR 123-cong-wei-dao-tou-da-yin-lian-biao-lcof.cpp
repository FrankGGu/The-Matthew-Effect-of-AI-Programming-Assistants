class Solution {
public:
    vector<int> reversePrint(ListNode* head) {
        vector<int> result;
        ListNode* current = head;
        while (current) {
            result.push_back(current->val);
            current = current->next;
        }
        reverse(result.begin(), result.end());
        return result;
    }
};