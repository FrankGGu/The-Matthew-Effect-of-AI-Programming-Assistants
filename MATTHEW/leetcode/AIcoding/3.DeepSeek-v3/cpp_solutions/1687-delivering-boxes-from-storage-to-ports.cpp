class Solution {
public:
    int boxDelivering(vector<vector<int>>& boxes, int portsCount, int maxBoxes, int maxWeight) {
        int n = boxes.size();
        vector<int> dp(n + 1, INT_MAX);
        dp[0] = 0;

        int left = 0;
        int currentWeight = 0;
        int trips = 0;

        for (int right = 0; right < n; ++right) {
            if (right == 0 || boxes[right][0] != boxes[right - 1][0]) {
                trips++;
            }
            currentWeight += boxes[right][1];

            while (right - left + 1 > maxBoxes || currentWeight > maxWeight || 
                   (left < right && dp[left] == dp[left + 1])) {
                currentWeight -= boxes[left][1];
                if (boxes[left][0] != boxes[left + 1][0]) {
                    trips--;
                }
                left++;
            }

            dp[right + 1] = dp[left] + trips + 1;
        }

        return dp[n];
    }
};