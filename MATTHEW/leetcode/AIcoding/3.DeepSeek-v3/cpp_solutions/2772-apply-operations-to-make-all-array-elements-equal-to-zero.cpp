class Solution {
public:
    bool checkArray(vector<int>& nums, int k) {
        int n = nums.size();
        vector<int> diff(n + 1, 0);
        int current = 0;

        for (int i = 0; i < n; ++i) {
            current += diff[i];
            nums[i] += current;

            if (nums[i] == 0) {
                continue;
            } else if (nums[i] < 0 || i + k > n) {
                return false;
            } else {
                int delta = -nums[i];
                current += delta;
                if (i + k < n) {
                    diff[i + k] -= delta;
                }
                nums[i] = 0;
            }
        }

        return true;
    }
};