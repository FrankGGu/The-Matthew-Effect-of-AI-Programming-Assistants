class Solution {
public:
    int countWays(vector<int>& buildings) {
        int n = buildings.size();
        long long total = 0, left = 0, right = 0;

        for (int b : buildings) {
            if (b == 1) total++;
        }

        if (total < 3) return 0;

        vector<long long> leftCount(n, 0), rightCount(n, 0);

        for (int i = 0; i < n; i++) {
            if (buildings[i] == 1) left++;
            if (i > 0) leftCount[i] = leftCount[i - 1] + (buildings[i - 1] == 1 ? 1 : 0);
        }

        for (int i = n - 1; i >= 0; i--) {
            if (buildings[i] == 1) right++;
            if (i < n - 1) rightCount[i] = rightCount[i + 1] + (buildings[i + 1] == 1 ? 1 : 0);
        }

        long long ways = 0;

        for (int i = 0; i < n; i++) {
            if (buildings[i] == 0) {
                ways += leftCount[i] * rightCount[i];
            }
        }

        return ways % 1000000007;
    }
};