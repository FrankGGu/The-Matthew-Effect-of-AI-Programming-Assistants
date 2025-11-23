class Solution {
public:
    bool canPartitionKSubsets(vector<int>& nums, int k) {
        int sum = accumulate(nums.begin(), nums.end(), 0);
        if (sum % k != 0) return false;
        int target = sum / k;
        sort(nums.rbegin(), nums.rend());
        vector<bool> visited(nums.size(), false);
        return backtrack(nums, k, target, 0, 0, visited);
    }

    bool backtrack(vector<int>& nums, int k, int target, int start, int current_sum, vector<bool>& visited) {
        if (k == 1) return true;
        if (current_sum == target) {
            return backtrack(nums, k - 1, target, 0, 0, visited);
        }
        for (int i = start; i < nums.size(); ++i) {
            if (!visited[i] && current_sum + nums[i] <= target) {
                visited[i] = true;
                if (backtrack(nums, k, target, i + 1, current_sum + nums[i], visited)) {
                    return true;
                }
                visited[i] = false;
            }
        }
        return false;
    }
};