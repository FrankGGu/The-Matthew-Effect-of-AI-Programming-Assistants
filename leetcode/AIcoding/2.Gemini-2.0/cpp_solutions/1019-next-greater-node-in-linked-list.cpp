#include <vector>
#include <stack>

using namespace std;

struct ListNode {
    int val;
    ListNode *next;
    ListNode() : val(0), next(nullptr) {}
    ListNode(int x) : val(x), next(nullptr) {}
    ListNode(int x, ListNode *next) : val(x), next(next) {}
};

class Solution {
public:
    vector<int> nextLargerNodes(ListNode* head) {
        vector<int> nums;
        ListNode* curr = head;
        while (curr) {
            nums.push_back(curr->val);
            curr = curr->next;
        }

        int n = nums.size();
        vector<int> result(n, 0);
        stack<int> s;

        for (int i = 0; i < n; ++i) {
            while (!s.empty() && nums[i] > nums[s.top()]) {
                result[s.top()] = nums[i];
                s.pop();
            }
            s.push(i);
        }

        return result;
    }
};