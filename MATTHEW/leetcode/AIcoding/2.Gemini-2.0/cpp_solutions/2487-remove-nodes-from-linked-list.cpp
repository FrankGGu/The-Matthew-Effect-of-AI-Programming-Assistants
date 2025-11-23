class Solution {
public:
    ListNode* removeNodes(ListNode* head) {
        vector<int> nums;
        ListNode* curr = head;
        while (curr) {
            nums.push_back(curr->val);
            curr = curr->next;
        }

        vector<int> stack;
        for (int num : nums) {
            while (!stack.empty() && stack.back() < num) {
                stack.pop_back();
            }
            stack.push_back(num);
        }

        ListNode* dummy = new ListNode(0);
        curr = dummy;
        for (int num : stack) {
            curr->next = new ListNode(num);
            curr = curr->next;
        }

        return dummy->next;
    }
};