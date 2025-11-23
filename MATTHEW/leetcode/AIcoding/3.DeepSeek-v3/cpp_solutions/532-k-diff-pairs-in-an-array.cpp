class Solution {
public:
    int findPairs(vector<int>& nums, int k) {
        unordered_map<int, int> freq;
        for (int num : nums) {
            freq[num]++;
        }
        int count = 0;
        for (auto it : freq) {
            if (k == 0) {
                if (it.second > 1) {
                    count++;
                }
            } else {
                if (freq.find(it.first + k) != freq.end()) {
                    count++;
                }
            }
        }
        return count;
    }
};