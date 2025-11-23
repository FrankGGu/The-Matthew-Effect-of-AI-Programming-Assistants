class Solution {
public:
    int countKSubarrays(vector<int>& nums, int k) {
        int n = nums.size();
        int count = 0;
        int sum = 0;
        unordered_map<int, int> prefixCount;
        prefixCount[0] = 1;

        for (int i = 0; i < n; i++) {
            sum += nums[i];

            if (prefixCount.find(sum - k) != prefixCount.end()) {
                count += prefixCount[sum - k];
            }

            prefixCount[sum]++;
        }

        return count;
    }
};