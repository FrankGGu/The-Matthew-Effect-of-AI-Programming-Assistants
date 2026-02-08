#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    int count(string num1, string num2, int min_sum, int max_sum) {
        int n1 = num1.size();
        int n2 = num2.size();
        int mod = 1e9 + 7;

        function<int(int, int, bool, bool, string)> solve = 
            [&](int index, int current_sum, bool tight_min, bool tight_max, string num) {
            if (current_sum > max_sum) {
                return 0;
            }
            if (index == num.size()) {
                return current_sum >= min_sum;
            }

            int &dp = memo[index][current_sum][tight_min][tight_max];
            if (dp != -1) {
                return dp;
            }

            int ans = 0;
            int low = (tight_min) ? (num1[index] - '0') : 0;
            int high = (tight_max) ? (num2[index] - '0') : 9;

            for (int digit = low; digit <= high; ++digit) {
                bool next_tight_min = tight_min && (digit == (num1[index] - '0'));
                bool next_tight_max = tight_max && (digit == (num2[index] - '0'));
                ans = (ans + solve(index + 1, current_sum + digit, next_tight_min, next_tight_max, num)) % mod;
            }
            return dp = ans;
        };

        function<int(int, int, bool, string)> solve2 = 
            [&](int index, int current_sum, bool tight_max, string num) {
            if (current_sum > max_sum) {
                return 0;
            }
            if (index == num.size()) {
                return current_sum >= min_sum;
            }

            int &dp = memo2[index][current_sum][tight_max];
            if (dp != -1) {
                return dp;
            }

            int ans = 0;
            int high = (tight_max) ? (num[index] - '0') : 9;

            for (int digit = 0; digit <= high; ++digit) {
                bool next_tight_max = tight_max && (digit == (num[index] - '0'));
                ans = (ans + solve2(index + 1, current_sum + digit, next_tight_max, num)) % mod;
            }
            return dp = ans;
        };

        memo.assign(n2, vector<vector<vector<int>>>(max_sum + 1, vector<vector<int>>(2, vector<int>(2, -1))));
        memo2.assign(n2, vector<vector<int>>(max_sum + 1, vector<int>(2, -1)));

        return solve2(0, 0, true, num2) ;
    }
private:
    vector<vector<vector<vector<int>>>> memo;
    vector<vector<vector<int>>> memo2;
};