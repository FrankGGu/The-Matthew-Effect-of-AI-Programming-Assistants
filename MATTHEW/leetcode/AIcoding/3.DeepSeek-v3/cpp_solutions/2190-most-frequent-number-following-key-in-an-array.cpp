class Solution {
public:
    int mostFrequent(vector<int>& nums, int key) {
        unordered_map<int, int> freq;
        int maxFreq = 0;
        int result = 0;

        for (int i = 0; i < nums.size() - 1; ++i) {
            if (nums[i] == key) {
                int target = nums[i + 1];
                freq[target]++;
                if (freq[target] > maxFreq) {
                    maxFreq = freq[target];
                    result = target;
                }
            }
        }

        return result;
    }
};