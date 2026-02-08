class Solution {
public:
    int countCompleteSubarrays(vector<int>& nums) {
        unordered_map<int, int> freq;
        int totalUnique = 0, result = 0;
        int n = nums.size();

        for (int num : nums) {
            if (freq[num] == 0) totalUnique++;
            freq[num]++;
        }

        freq.clear();
        int left = 0;

        for (int right = 0; right < n; right++) {
            freq[nums[right]]++;

            while (freq.size() == totalUnique) {
                result += n - right;
                freq[nums[left]]--;
                if (freq[nums[left]] == 0) {
                    freq.erase(nums[left]);
                }
                left++;
            }
        }

        return result;
    }
};