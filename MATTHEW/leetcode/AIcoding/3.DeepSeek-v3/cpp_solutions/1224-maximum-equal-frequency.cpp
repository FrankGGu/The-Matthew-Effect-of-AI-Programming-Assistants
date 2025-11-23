class Solution {
public:
    int maxEqualFreq(vector<int>& nums) {
        unordered_map<int, int> freq, count;
        int res = 0, maxFreq = 0;
        for (int i = 0; i < nums.size(); ++i) {
            int num = nums[i];
            if (count[num] > 0) {
                freq[count[num]]--;
            }
            count[num]++;
            maxFreq = max(maxFreq, count[num]);
            freq[count[num]]++;
            bool ok = maxFreq == 1 ||
                     (freq[maxFreq] * maxFreq + freq[maxFreq - 1] * (maxFreq - 1) == i + 1 && (freq[maxFreq] == 1 || freq[maxFreq - 1] == 1)) ||
                     (freq[1] == 1 && freq[maxFreq] * maxFreq == i);
            if (ok) {
                res = i + 1;
            }
        }
        return res;
    }
};