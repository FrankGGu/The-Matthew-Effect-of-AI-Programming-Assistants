class Solution {
public:
    int minLengthAfterRemovals(vector<int>& nums) {
        unordered_map<int, int> freq;
        for (int num : nums) {
            freq[num]++;
        }
        int max_freq = 0;
        for (auto& [num, cnt] : freq) {
            max_freq = max(max_freq, cnt);
        }
        int n = nums.size();
        if (max_freq <= n / 2) {
            return n % 2;
        } else {
            return 2 * max_freq - n;
        }
    }
};