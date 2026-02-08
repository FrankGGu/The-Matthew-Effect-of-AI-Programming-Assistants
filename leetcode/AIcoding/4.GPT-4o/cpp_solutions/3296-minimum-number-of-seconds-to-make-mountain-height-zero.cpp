class Solution {
public:
    long long minimumSeconds(vector<int>& nums) {
        int n = nums.size();
        unordered_map<int, long long> count;
        long long totalSeconds = 0;

        for (int i = 0; i < n; ++i) {
            count[nums[i]]++;
        }

        for (auto &[height, cnt] : count) {
            long long seconds = 0;
            for (int j = 1; j <= 2; ++j) {
                seconds += count[height - j] * j;
            }
            totalSeconds += seconds;
        }

        return totalSeconds;
    }
};