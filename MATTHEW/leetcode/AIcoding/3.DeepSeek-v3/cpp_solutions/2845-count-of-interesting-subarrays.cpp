class Solution {
public:
    long long countInterestingSubarrays(vector<int>& nums, int modulo, int k) {
        unordered_map<int, int> prefixCount;
        prefixCount[0] = 1;
        long long res = 0;
        int prefix = 0;
        for (int num : nums) {
            if (num % modulo == k) {
                prefix = (prefix + 1) % modulo;
            }
            int target = (prefix - k + modulo) % modulo;
            res += prefixCount[target];
            prefixCount[prefix]++;
        }
        return res;
    }
};