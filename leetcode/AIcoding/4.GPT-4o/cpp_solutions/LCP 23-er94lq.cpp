class Solution {
public:
    vector<int> specialPerm(vector<int>& nums) {
        int n = nums.size();
        vector<int> result(n);
        vector<bool> used(n, false);
        function<void(int)> backtrack = [&](int idx) {
            if (idx == n) {
                return;
            }
            for (int i = 0; i < n; ++i) {
                if (!used[i]) {
                    if (idx == 0 || (nums[idx - 1] % nums[i] == 0 || nums[i] % nums[idx - 1] == 0)) {
                        used[i] = true;
                        result[idx] = nums[i];
                        backtrack(idx + 1);
                        used[i] = false;
                    }
                }
            }
        };
        backtrack(0);
        return result;
    }
};