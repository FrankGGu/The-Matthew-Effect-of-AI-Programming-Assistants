class Solution {
public:
    long long countAlmostEqualPairs(vector<int>& nums) {
        unordered_map<long long, long long> freq;
        long long res = 0;
        for (int num : nums) {
            res += freq[num - 1] + freq[num] + freq[num + 1];
            freq[num]++;
        }
        return res;
    }
};