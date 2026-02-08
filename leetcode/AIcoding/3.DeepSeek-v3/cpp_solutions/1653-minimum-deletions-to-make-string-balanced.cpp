class Solution {
public:
    int minimumDeletions(string s) {
        int n = s.size();
        vector<int> a(n + 1, 0);
        vector<int> b(n + 1, 0);

        for (int i = 1; i <= n; ++i) {
            a[i] = a[i - 1] + (s[i - 1] == 'b' ? 1 : 0);
        }

        for (int i = n - 1; i >= 0; --i) {
            b[i] = b[i + 1] + (s[i] == 'a' ? 1 : 0);
        }

        int res = INT_MAX;
        for (int i = 0; i <= n; ++i) {
            res = min(res, a[i] + b[i]);
        }

        return res;
    }
};