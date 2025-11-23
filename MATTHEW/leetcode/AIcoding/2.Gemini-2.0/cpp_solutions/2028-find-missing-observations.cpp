#include <vector>
#include <numeric>

using namespace std;

class Solution {
public:
    vector<int> missingRolls(vector<int>& rolls, int mean, int n) {
        int m = rolls.size();
        int sum_rolls = accumulate(rolls.begin(), rolls.end(), 0);
        int missing_sum = mean * (n + m) - sum_rolls;

        if (missing_sum < n || missing_sum > 6 * n) {
            return {};
        }

        int base = missing_sum / n;
        int remainder = missing_sum % n;

        vector<int> result(n, base);
        for (int i = 0; i < remainder; ++i) {
            result[i]++;
        }

        return result;
    }
};