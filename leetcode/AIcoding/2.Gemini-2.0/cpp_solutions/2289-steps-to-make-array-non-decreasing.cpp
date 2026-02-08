#include <vector>
#include <stack>

using namespace std;

class Solution {
public:
    int totalSteps(vector<int>& nums) {
        int n = nums.size();
        vector<int> steps(n, 0);
        stack<int> st;
        int ans = 0;

        for (int i = n - 1; i >= 0; --i) {
            while (!st.empty() && nums[i] > nums[st.top()]) {
                steps[i] = max(steps[i] + 1, steps[st.top()]);
                st.pop();
            }
            st.push(i);
            ans = max(ans, steps[i]);
        }

        return ans;
    }
};