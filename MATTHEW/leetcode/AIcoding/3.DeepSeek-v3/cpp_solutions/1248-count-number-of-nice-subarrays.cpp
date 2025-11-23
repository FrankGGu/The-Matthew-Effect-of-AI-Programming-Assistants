class Solution {
public:
    int numberOfSubarrays(vector<int>& nums, int k) {
        unordered_map<int, int> prefixCount;
        prefixCount[0] = 1;
        int sum = 0;
        int result = 0;

        for (int num : nums) {
            sum += num % 2;
            if (prefixCount.find(sum - k) != prefixCount.end()) {
                result += prefixCount[sum - k];
            }
            prefixCount[sum]++;
        }

        return result;
    }
};