#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int numberOfBeautifulIntegers(int low, int high, int k) {
        return countBeautiful(high, k) - countBeautiful(low - 1, k);
    }

private:
    int countBeautiful(int num, int k) {
        string s = to_string(num);
        int n = s.length();
        vector<vector<vector<int>>> dp(n + 1, vector<vector<int>>(n + 1, vector<int>(2, -1)));

        function<int(int, int, bool)> solve = [&](int idx, int diff, bool tight) {
            if (idx == n) {
                return (diff == 0);
            }

            if (dp[idx][diff][tight] != -1) {
                return dp[idx][diff][tight];
            }

            int ans = 0;
            int upper_bound = tight ? (s[idx] - '0') : 9;

            for (int digit = 0; digit <= upper_bound; ++digit) {
                int new_diff = diff;
                if (digit % 2 == 0) {
                    new_diff--;
                } else {
                    new_diff++;
                }
                ans += solve(idx + 1, new_diff, tight && (digit == upper_bound));
            }

            return dp[idx][diff][tight] = ans;
        };

        int ans = 0;
        for(int len = 1; len <= n; ++len){
            if(len % 2 != 0) continue;
            string temp(len, '0');
            if(len < n){
                dp.assign(len + 1, vector<vector<int>>(len + 1, vector<int>(2, -1)));
                ans += solve(0, len / 2, true);
            } else {
                dp.assign(n + 1, vector<vector<int>>(n + 1, vector<int>(2, -1)));
                ans += solve(0, n / 2, true);
            }
        }

        int result = 0;
        string str_num = to_string(num);
        int sum = 0;
        for(char c : str_num){
            int digit = c - '0';
            if(digit % 2 == 0) sum--;
            else sum++;
        }
        if(sum == 0 && num % k == 0){
            result = 1;
        }

        return ans;
    }
};