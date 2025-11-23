class Solution {
public:
    bool find132pattern(vector<int>& nums) {
        int n = nums.size();
        if (n < 3) return false;

        vector<int> minArr(n);
        minArr[0] = nums[0];
        for (int i = 1; i < n; ++i) {
            minArr[i] = min(minArr[i - 1], nums[i]);
        }

        stack<int> s;
        for (int j = n - 1; j >= 0; --j) {
            while (!s.empty() && s.top() <= minArr[j]) {
                s.pop();
            }
            if (!s.empty() && s.top() < nums[j]) {
                return true;
            }
            s.push(nums[j]);
        }

        return false;
    }
};