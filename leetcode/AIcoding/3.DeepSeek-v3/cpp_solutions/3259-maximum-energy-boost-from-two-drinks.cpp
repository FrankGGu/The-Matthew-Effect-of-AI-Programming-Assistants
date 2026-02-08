class Solution {
public:
    int maximumEnergy(vector<int>& energy, int k) {
        int n = energy.size();
        vector<int> dp(n, 0);
        int max_energy = INT_MIN;

        for (int i = n - 1; i >= 0; --i) {
            dp[i] = energy[i];
            if (i + k < n) {
                dp[i] += dp[i + k];
            }
            max_energy = max(max_energy, dp[i]);
        }

        return max_energy;
    }
};