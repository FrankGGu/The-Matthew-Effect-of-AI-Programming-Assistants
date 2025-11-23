class Solution {
public:
    long long countBadPairs(vector<int>& nums) {
        long long n = nums.size();
        long long totalPairs = n * (n - 1) / 2;
        long long goodPairs = 0;
        unordered_map<long long, long long> countMap;

        for (int i = 0; i < n; ++i) {
            goodPairs += countMap[i - nums[i]]++;
        }

        return totalPairs - goodPairs;
    }
};