class Solution {
public:
    long long maxProduct(string s) {
        int n = s.size();
        vector<int> d1(n), d2(n);
        for (int i = 0, l = 0, r = -1; i < n; ++i) {
            int k = (i > r) ? 1 : min(d1[l + r - i], r - i + 1);
            while (0 <= i - k && i + k < n && s[i - k] == s[i + k]) {
                ++k;
            }
            d1[i] = k--;
            if (i + k > r) {
                l = i - k;
                r = i + k;
            }
        }
        for (int i = 0, l = 0, r = -1; i < n; ++i) {
            int k = (i > r) ? 0 : min(d2[l + r - i + 1], r - i + 1);
            while (0 <= i - k - 1 && i + k < n && s[i - k - 1] == s[i + k]) {
                ++k;
            }
            d2[i] = k--;
            if (i + k > r) {
                l = i - k - 1;
                r = i + k;
            }
        }
        vector<int> left(n, 0), right(n, 0);
        for (int i = 0; i < n; ++i) {
            int l = i - d1[i] + 1;
            int r = i + d1[i] - 1;
            left[r] = max(left[r], 2 * d1[i] - 1);
            if (i + 1 < n) {
                l = i - d2[i + 1] + 1;
                r = i + d2[i + 1];
                left[r] = max(left[r], 2 * d2[i + 1]);
            }
        }
        for (int i = 1; i < n; ++i) {
            left[i] = max(left[i], left[i - 1]);
        }
        for (int i = n - 1; i >= 0; --i) {
            int l = i - d1[i] + 1;
            int r = i + d1[i] - 1;
            right[l] = max(right[l], 2 * d1[i] - 1);
            if (i + 1 < n) {
                l = i - d2[i + 1] + 1;
                r = i + d2[i + 1];
                right[l] = max(right[l], 2 * d2[i + 1]);
            }
        }
        for (int i = n - 2; i >= 0; --i) {
            right[i] = max(right[i], right[i + 1]);
        }
        long long res = 0;
        for (int i = 0; i < n - 1; ++i) {
            res = max(res, (long long)left[i] * right[i + 1]);
        }
        return res;
    }
};