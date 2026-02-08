class Solution {
public:
    bool canPartitionKSubsets(vector<int>& nums, int k) {
        int total = accumulate(nums.begin(), nums.end(), 0);
        if (total % k != 0) return false;
        int target = total / k;
        vector<bool> visited(nums.size(), false);
        return backtrack(nums, visited, 0, 0, k, target);
    }

    bool backtrack(vector<int>& nums, vector<bool>& visited, int startIndex, int currentSum, int k, int target) {
        if (k == 1) return true;
        if (currentSum == target) return backtrack(nums, visited, 0, 0, k - 1, target);

        for (int i = startIndex; i < nums.size(); i++) {
            if (!visited[i] && currentSum + nums[i] <= target) {
                visited[i] = true;
                if (backtrack(nums, visited, i + 1, currentSum + nums[i], k, target)) return true;
                visited[i] = false;
            }
        }
        return false;
    }
};