class Solution {
public:
    int longestWPI(vector<int>& hours) {
        int n = hours.size();
        unordered_map<int, int> prefixSum;
        int sum = 0, maxLength = 0;

        for (int i = 0; i < n; ++i) {
            sum += (hours[i] > 8 ? 1 : -1);
            if (sum > 0) {
                maxLength = i + 1;
            } else {
                if (prefixSum.find(sum - 1) != prefixSum.end()) {
                    maxLength = max(maxLength, i - prefixSum[sum - 1]);
                }
                if (prefixSum.find(sum) == prefixSum.end()) {
                    prefixSum[sum] = i;
                }
            }
        }

        return maxLength;
    }
};