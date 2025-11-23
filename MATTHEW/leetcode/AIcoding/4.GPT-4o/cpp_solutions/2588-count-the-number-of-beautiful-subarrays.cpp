class Solution {
public:
    int beautifulSubarrays(vector<int>& nums) {
        unordered_map<int, int> prefixCount;
        prefixCount[0] = 1;
        int count = 0, prefixXOR = 0;

        for (int num : nums) {
            prefixXOR ^= num;
            count += prefixCount[prefixXOR];
            prefixCount[prefixXOR]++;
        }

        return count;
    }
};