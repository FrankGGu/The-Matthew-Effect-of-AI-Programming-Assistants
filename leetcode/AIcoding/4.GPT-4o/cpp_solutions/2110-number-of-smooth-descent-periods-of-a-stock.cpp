class Solution {
public:
    long long getDescentPeriods(vector<int>& prices) {
        long long count = 0;
        int n = prices.size();
        for (int i = 0; i < n; ) {
            int j = i;
            while (j + 1 < n && prices[j] - prices[j + 1] == 1) {
                j++;
            }
            long long length = j - i + 1;
            count += (length * (length + 1)) / 2;
            i = j + 1;
        }
        return count;
    }
};