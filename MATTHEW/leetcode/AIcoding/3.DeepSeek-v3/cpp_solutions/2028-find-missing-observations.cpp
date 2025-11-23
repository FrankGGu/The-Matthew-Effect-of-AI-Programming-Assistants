class Solution {
public:
    vector<int> missingRolls(vector<int>& rolls, int mean, int n) {
        int m = rolls.size();
        int sum = mean * (m + n);
        int sum_m = accumulate(rolls.begin(), rolls.end(), 0);
        int sum_n = sum - sum_m;

        if (sum_n < n || sum_n > 6 * n) {
            return {};
        }

        vector<int> res(n, sum_n / n);
        int rem = sum_n % n;
        for (int i = 0; i < rem; ++i) {
            res[i]++;
        }

        return res;
    }
};