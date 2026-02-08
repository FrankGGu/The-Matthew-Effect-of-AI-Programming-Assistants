class Solution {
public:
    int numComponents(ListNode* head, vector<int>& nums) {
        unordered_set<int> numSet(nums.begin(), nums.end());
        int components = 0;
        bool inComponent = false;

        while (head != nullptr) {
            if (numSet.count(head->val)) {
                if (!inComponent) {
                    components++;
                    inComponent = true;
                }
            } else {
                inComponent = false;
            }
            head = head->next;
        }

        return components;
    }
};