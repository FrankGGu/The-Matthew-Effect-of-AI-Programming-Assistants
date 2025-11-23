class Solution {
public:
    int minOperations(vector<int>& nums, int k) {
        unordered_set<int> required;
        for (int i = 1; i <= k; ++i) {
            required.insert(i);
        }
        int n = nums.size();
        int operations = 0;
        for (int i = n - 1; i >= 0; --i) {
            if (required.count(nums[i])) {
                required.erase(nums[i]);
            }
            operations++;
            if (required.empty()) {
                break;
            }
        }
        return operations;
    }
};