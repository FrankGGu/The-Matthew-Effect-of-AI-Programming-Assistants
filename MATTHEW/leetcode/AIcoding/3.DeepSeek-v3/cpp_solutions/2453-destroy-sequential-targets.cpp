class Solution {
public:
    int destroyTargets(vector<int>& nums, int space) {
        unordered_map<int, int> freq;
        for (int num : nums) {
            int mod = num % space;
            freq[mod]++;
        }

        int maxFreq = 0;
        for (auto& [mod, cnt] : freq) {
            if (cnt > maxFreq) {
                maxFreq = cnt;
            }
        }

        int minNum = INT_MAX;
        for (int num : nums) {
            if (freq[num % space] == maxFreq) {
                if (num < minNum) {
                    minNum = num;
                }
            }
        }

        return minNum;
    }
};