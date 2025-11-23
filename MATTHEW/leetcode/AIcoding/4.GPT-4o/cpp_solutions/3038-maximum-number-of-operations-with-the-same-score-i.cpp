class Solution {
public:
    int maximumOperations(vector<int>& nums, int target) {
        unordered_set<int> seen;
        int operations = 0;
        for (int num : nums) {
            int complement = target - num;
            if (seen.count(complement)) {
                operations++;
                seen.erase(complement);
            } else {
                seen.insert(num);
            }
        }
        return operations;
    }
};