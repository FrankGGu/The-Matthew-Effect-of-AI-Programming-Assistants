#include <vector>
#include <stack>
using namespace std;

class Solution {
public:
    int totalSteps(vector<int>& nums) {
        stack<pair<int, int>> st;
        int res = 0;
        for (int num : nums) {
            int steps = 0;
            while (!st.empty() && st.top().first <= num) {
                steps = max(steps, st.top().second);
                st.pop();
            }
            if (!st.empty()) {
                steps++;
            } else {
                steps = 0;
            }
            res = max(res, steps);
            st.push({num, steps});
        }
        return res;
    }
};