class Solution {
public:
    int countSpecialNumbers(int n) {
        string s = to_string(n);
        int len = s.size(), ans = 0;

        for (int i = 1; i < len; ++i) {
            ans += 9 * perm(9, i - 1);
        }

        unordered_set<int> used;
        for (int i = 0; i < len; ++i) {
            for (int j = (i == 0 ? 1 : 0); j < s[i] - '0'; ++j) {
                if (used.count(j) == 0) {
                    ans += perm(9 - i, len - i - 1);
                }
            }
            if (used.count(s[i] - '0')) break;
            used.insert(s[i] - '0');
        }

        return ans + 1;
    }

private:
    int perm(int a, int b) {
        int res = 1;
        for (int i = 0; i < b; ++i) {
            res *= (a - i);
        }
        return res;
    }
};