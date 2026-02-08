#include <vector>
#include <stack>
using namespace std;

class Solution {
public:
    int totalSteps(vector<int>& nums) {
        stack<pair<int, int>> st;
        int res = 0;
        for (int i = nums.size() - 1; i >= 0; --i) {
            int cnt = 0;
            while (!st.empty() && nums[i] > st.top().first) {
                cnt = max(cnt + 1, st.top().second);
                st.pop();
            }
            res = max(res, cnt);
            st.push({nums[i], cnt});
        }
        return res;
    }
};