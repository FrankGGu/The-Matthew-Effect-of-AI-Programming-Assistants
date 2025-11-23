class Solution {
public:
    int maxNumOfSubstrings(string s) {
        int n = s.size();
        vector<int> left(n), right(n);
        unordered_map<char, int> last_index;

        for (int i = 0; i < n; ++i) {
            last_index[s[i]] = i;
        }

        for (int i = 0; i < n; ++i) {
            if (s[i] == ' ') continue;
            int end = last_index[s[i]];
            for (int j = i; j <= end; ++j) {
                end = max(end, last_index[s[j]]);
            }
            left[i] = end;
        }

        for (int i = n - 1; i >= 0; --i) {
            if (s[i] == ' ') continue;
            int start = last_index[s[i]];
            for (int j = i; j >= start; --j) {
                start = min(start, last_index[s[j]]);
            }
            right[i] = start;
        }

        vector<int> dp(n, 0);
        for (int i = 0; i < n; ++i) {
            if (left[i] > 0) {
                dp[left[i]] = max(dp[left[i]], right[i]);
            }
        }

        int result = 0;
        for (int i = 0; i < n; ++i) {
            result = max(result, dp[i]);
        }

        return result;
    }
};