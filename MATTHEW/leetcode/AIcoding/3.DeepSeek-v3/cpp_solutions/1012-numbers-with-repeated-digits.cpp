class Solution {
public:
    int numDupDigitsAtMostN(int N) {
        string s = to_string(N);
        int n = s.size();
        int res = 0;
        for (int i = 1; i < n; ++i) {
            res += 9 * perm(9, i - 1);
        }
        unordered_set<int> seen;
        for (int i = 0; i < n; ++i) {
            int digit = s[i] - '0';
            for (int j = (i == 0 ? 1 : 0); j < digit; ++j) {
                if (seen.count(j) == 0) {
                    res += perm(9 - i, n - i - 1);
                }
            }
            if (seen.count(digit)) break;
            seen.insert(digit);
        }
        return N - res;
    }

    int perm(int m, int n) {
        int res = 1;
        for (int i = 0; i < n; ++i) {
            res *= (m - i);
        }
        return res;
    }
};