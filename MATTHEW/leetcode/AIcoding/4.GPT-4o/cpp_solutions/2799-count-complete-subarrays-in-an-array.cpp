class Solution {
public:
    int countCompleteSubarrays(vector<int>& nums) {
        int n = nums.size();
        unordered_map<int, int> freq;
        int uniqueCount = 0;
        int result = 0;

        for (int num : nums) {
            if (freq[num]++ == 0) {
                uniqueCount++;
            }
        }

        freq.clear();
        int left = 0;

        for (int right = 0; right < n; right++) {
            if (freq[nums[right]]++ == 0) {
                uniqueCount--;
            }

            while (uniqueCount < 0) {
                if (--freq[nums[left]] == 0) {
                    uniqueCount++;
                }
                left++;
            }

            result += right - left + 1;
        }

        return result;
    }
};