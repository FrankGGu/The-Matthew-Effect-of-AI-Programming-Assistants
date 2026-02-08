class Solution {
public:
    long long beautifulSubarrays(vector<int>& nums) {
        unordered_map<int, int> prefix_counts;
        prefix_counts[0] = 1;
        int prefix = 0;
        long long result = 0;

        for (int num : nums) {
            prefix ^= num;
            result += prefix_counts[prefix];
            prefix_counts[prefix]++;
        }

        return result;
    }
};