class Solution {
public:
    long long maxStrength(vector<int>& nums) {
        long long max_strength = nums[0];
        long long min_strength = nums[0];
        long long result = nums[0];

        for (int i = 1; i < nums.size(); ++i) {
            long long current = nums[i];
            long long temp_max = max_strength;
            long long temp_min = min_strength;

            max_strength = max({current, temp_max * current, temp_min * current});
            min_strength = min({current, temp_max * current, temp_min * current});

            result = max(result, max_strength);
        }

        return result;
    }
};