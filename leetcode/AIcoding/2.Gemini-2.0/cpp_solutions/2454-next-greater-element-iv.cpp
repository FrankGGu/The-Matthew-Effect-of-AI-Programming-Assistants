#include <vector>
#include <stack>

using namespace std;

class Solution {
public:
    vector<int> secondGreaterElement(vector<int>& nums) {
        int n = nums.size();
        vector<int> ans(n, -1);
        stack<int> s1, s2;
        vector<int> tmp;

        for (int i = 0; i < n; ++i) {
            while (!s2.empty() && nums[s2.top()] < nums[i]) {
                ans[s2.top()] = nums[i];
                s2.pop();
            }

            while (!s1.empty() && nums[s1.top()] < nums[i]) {
                tmp.push_back(s1.top());
                s1.pop();
            }

            while (!tmp.empty()) {
                s2.push(tmp.back());
                tmp.pop_back();
            }

            s1.push(i);
        }

        return ans;
    }
};