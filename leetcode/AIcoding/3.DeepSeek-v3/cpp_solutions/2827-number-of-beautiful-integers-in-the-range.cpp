class Solution {
public:
    int numberOfBeautifulIntegers(int low, int high, int k) {
        return countBeautifulNumbers(high, k) - countBeautifulNumbers(low - 1, k);
    }

private:
    int countBeautifulNumbers(int num, int k) {
        string s = to_string(num);
        int n = s.size();
        int memo[n][k][21][2][2];
        memset(memo, -1, sizeof(memo));
        function<int(int, int, int, bool, bool)> dfs = [&](int pos, int mod, int diff, bool isLimit, bool isNum) -> int {
            if (pos == n) {
                return isNum && mod == 0 && diff == 10;
            }
            if (memo[pos][mod][diff][isLimit][isNum] != -1) {
                return memo[pos][mod][diff][isLimit][isNum];
            }
            int res = 0;
            if (!isNum) {
                res = dfs(pos + 1, mod, diff, false, false);
            }
            int up = isLimit ? s[pos] - '0' : 9;
            for (int d = isNum ? 0 : 1; d <= up; ++d) {
                int newMod = (mod * 10 + d) % k;
                int newDiff = diff + (d % 2 == 0 ? 1 : -1);
                res += dfs(pos + 1, newMod, newDiff, isLimit && d == up, true);
            }
            memo[pos][mod][diff][isLimit][isNum] = res;
            return res;
        };
        return dfs(0, 0, 10, true, false);
    }
};