class Solution {
public:
    int longestPushTime(vector<int>& pushTimes, string s) {
        int n = pushTimes.size();
        int maxTime = 0;
        int currentTime = 0;

        for (int i = 0; i < n; ++i) {
            if (i > 0 && s[i] == s[i - 1]) {
                currentTime += pushTimes[i];
            } else {
                currentTime = pushTimes[i];
            }
            maxTime = max(maxTime, currentTime);
        }

        return maxTime;
    }
};