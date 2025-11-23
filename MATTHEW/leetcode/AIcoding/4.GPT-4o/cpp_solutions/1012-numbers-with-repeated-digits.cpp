class Solution {
public:
    int numDupDigitsAtMostN(int N) {
        string s = to_string(N);
        int len = s.size(), res = 0;

        for (int i = 1; i < len; i++) {
            res += 9 * permutation(9, i - 1);
        }

        unordered_set<int> used;
        for (int i = 0; i < len; i++) {
            for (int j = (i == 0 ? 1 : 0); j < s[i] - '0'; j++) {
                if (!used.count(j)) {
                    res += permutation(9 - i, len - i - 1);
                }
            }
            if (used.count(s[i] - '0')) break;
            used.insert(s[i] - '0');
        }

        return N - res;
    }

    int permutation(int n, int k) {
        int res = 1;
        for (int i = 0; i < k; i++) {
            res *= (n - i);
        }
        return res;
    }
};