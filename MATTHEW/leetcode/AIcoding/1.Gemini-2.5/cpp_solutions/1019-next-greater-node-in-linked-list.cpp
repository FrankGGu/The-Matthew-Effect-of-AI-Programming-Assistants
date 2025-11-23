#include <vector>
#include <stack>

class Solution {
public:
    std::vector<int> nextLargerNodes(ListNode* head) {
        std::vector<int> nums;
        ListNode* current = head;
        while (current) {
            nums.push_back(current->val);
            current = current->next;
        }

        int n = nums.size();
        std::vector<int> result(n, 0);
        std::stack<int> s;

        for (int i = 0; i < n; ++i) {
            while (!s.empty() && nums[s.top()] < nums[i]) {
                result[s.top()] = nums[i];
                s.pop();
            }
            s.push(i);
        }

        return result;
    }
};