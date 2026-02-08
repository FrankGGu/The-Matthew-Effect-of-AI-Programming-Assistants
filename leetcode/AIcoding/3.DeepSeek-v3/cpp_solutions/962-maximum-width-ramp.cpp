class Solution {
public:
    int maxWidthRamp(vector<int>& nums) {
        stack<int> s;
        int n = nums.size();
        for (int i = 0; i < n; ++i) {
            if (s.empty() || nums[i] < nums[s.top()]) {
                s.push(i);
            }
        }

        int res = 0;
        for (int i = n - 1; i >= 0; --i) {
            while (!s.empty() && nums[i] >= nums[s.top()]) {
                res = max(res, i - s.top());
                s.pop();
            }
        }
        return res;
    }
};