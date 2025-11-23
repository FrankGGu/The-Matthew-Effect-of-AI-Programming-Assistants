class Solution {
public:
    int minimumScore(string s, string t) {
        int m = s.size(), n = t.size();
        vector<int> left(n, -1);
        int i = 0, j = 0;
        while (i < m && j < n) {
            if (s[i] == t[j]) {
                left[j] = i;
                j++;
            }
            i++;
        }
        vector<int> right(n, -1);
        i = m - 1, j = n - 1;
        while (i >= 0 && j >= 0) {
            if (s[i] == t[j]) {
                right[j] = i;
                j--;
            }
            i--;
        }
        if (j < 0) return 0;
        int res = n;
        for (int k = 0; k < n; k++) {
            if (left[k] != -1) {
                int l = k + 1, r = n - 1;
                while (l <= r) {
                    int mid = l + (r - l) / 2;
                    if (right[mid] != -1 && right[mid] > left[k]) {
                        res = min(res, mid - k - 1);
                        r = mid - 1;
                    } else {
                        l = mid + 1;
                    }
                }
            }
        }
        return res;
    }
};