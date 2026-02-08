class Solution {
public:
    int mostFrequent(vector<int>& nums, int key) {
        unordered_map<int, int> freq;
        for (int i = 0; i < nums.size() - 1; i++) {
            if (nums[i] == key) {
                freq[nums[i + 1]]++;
            }
        }
        int maxFreq = 0, result = -1;
        for (const auto& pair : freq) {
            if (pair.second > maxFreq) {
                maxFreq = pair.second;
                result = pair.first;
            }
        }
        return result;
    }
};