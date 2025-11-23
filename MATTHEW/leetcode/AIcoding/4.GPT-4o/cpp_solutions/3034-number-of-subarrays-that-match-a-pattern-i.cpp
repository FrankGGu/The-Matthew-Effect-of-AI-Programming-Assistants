class Solution {
public:
    int countSubarrays(vector<int>& nums, vector<int>& pattern) {
        int n = nums.size(), m = pattern.size();
        if (n < m) return 0;

        int count = 0, pCount = 0;
        unordered_map<int, int> numCount, patternCount;

        for (int num : pattern) {
            patternCount[num]++;
        }

        for (int i = 0; i < m; i++) {
            if (patternCount.find(nums[i]) != patternCount.end()) {
                numCount[nums[i]]++;
                if (numCount[nums[i]] <= patternCount[nums[i]]) {
                    pCount++;
                }
            }
        }

        if (pCount == m) count++;

        for (int i = m; i < n; i++) {
            if (patternCount.find(nums[i]) != patternCount.end()) {
                numCount[nums[i]]++;
                if (numCount[nums[i]] <= patternCount[nums[i]]) {
                    pCount++;
                }
            }

            if (patternCount.find(nums[i - m]) != patternCount.end()) {
                if (numCount[nums[i - m]] <= patternCount[nums[i - m]]) {
                    pCount--;
                }
                numCount[nums[i - m]]--;
            }

            if (pCount == m) count++;
        }

        return count;
    }
};