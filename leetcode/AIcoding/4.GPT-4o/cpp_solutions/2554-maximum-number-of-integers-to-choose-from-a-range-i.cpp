class Solution {
public:
    int maxCount(int banned, int n, int maxSum) {
        int count = 0;
        int sum = 0;

        for (int i = 1; i <= n; ++i) {
            if (i == banned) continue;
            if (sum + i > maxSum) break;
            sum += i;
            count++;
        }

        return count;
    }
};