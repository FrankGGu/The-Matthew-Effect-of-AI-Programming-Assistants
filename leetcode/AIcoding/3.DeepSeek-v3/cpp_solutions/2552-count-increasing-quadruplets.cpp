class Solution {
public:
    long long countQuadruplets(vector<int>& nums) {
        int n = nums.size();
        vector<vector<int>> less(n, vector<int>(n + 1, 0));
        vector<vector<int>> greater(n, vector<int>(n + 1, 0));

        for (int j = 0; j < n; ++j) {
            for (int v = 1; v <= n; ++v) {
                less[j][v] = (j > 0 ? less[j - 1][v] : 0) + (nums[j] < v ? 1 : 0);
            }
        }

        for (int k = n - 1; k >= 0; --k) {
            for (int v = 1; v <= n; ++v) {
                greater[k][v] = (k < n - 1 ? greater[k + 1][v] : 0) + (nums[k] > v ? 1 : 0);
            }
        }

        long long res = 0;
        for (int j = 1; j < n - 2; ++j) {
            for (int k = j + 1; k < n - 1; ++k) {
                if (nums[j] > nums[k]) {
                    res += less[j][nums[k]] * greater[k][nums[j]];
                }
            }
        }
        return res;
    }
};