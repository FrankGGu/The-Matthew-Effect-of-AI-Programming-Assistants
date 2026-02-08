class Solution {
public:
    int minimumTime(string s) {
        int n = s.size();
        vector<int> left(n), right(n);

        left[0] = (s[0] == '1');
        for (int i = 1; i < n; ++i) {
            left[i] = (s[i] == '1') ? min(left[i-1] + 2, i + 1) : left[i-1];
        }

        right[n-1] = (s[n-1] == '1');
        for (int i = n-2; i >= 0; --i) {
            right[i] = (s[i] == '1') ? min(right[i+1] + 2, n - i) : right[i+1];
        }

        int res = min(left[n-1], right[0]);
        for (int i = 0; i < n-1; ++i) {
            res = min(res, left[i] + right[i+1]);
        }

        return res;
    }
};