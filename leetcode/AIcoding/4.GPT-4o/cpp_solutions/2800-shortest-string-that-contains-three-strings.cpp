class Solution {
public:
    string shortestSuperstring(vector<string>& words) {
        int n = words.size();
        vector<vector<int>> overlap(n, vector<int>(n, 0));

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                if (i != j) {
                    int max_overlap = 0;
                    for (int k = 1; k <= min(words[i].size(), words[j].size()); ++k) {
                        if (words[i].substr(words[i].size() - k) == words[j].substr(0, k)) {
                            max_overlap = k;
                        }
                    }
                    overlap[i][j] = max_overlap;
                }
            }
        }

        vector<vector<int>> dp(1 << n, vector<int>(n, INT_MAX));
        vector<vector<int>> prev(1 << n, vector<int>(n, -1));

        for (int i = 0; i < n; ++i) {
            dp[1 << i][i] = words[i].size();
        }

        for (int mask = 0; mask < (1 << n); ++mask) {
            for (int i = 0; i < n; ++i) {
                if (mask & (1 << i)) {
                    for (int j = 0; j < n; ++j) {
                        if (!(mask & (1 << j))) {
                            int new_mask = mask | (1 << j);
                            int new_length = dp[mask][i] + words[j].size() - overlap[i][j];
                            if (new_length < dp[new_mask][j]) {
                                dp[new_mask][j] = new_length;
                                prev[new_mask][j] = i;
                            }
                        }
                    }
                }
            }
        }

        int min_length = INT_MAX, last_index = -1;
        for (int i = 0; i < n; ++i) {
            if (dp[(1 << n) - 1][i] < min_length) {
                min_length = dp[(1 << n) - 1][i];
                last_index = i;
            }
        }

        string result;
        int mask = (1 << n) - 1;
        while (last_index != -1) {
            result = words[last_index] + result;
            int prev_index = prev[mask][last_index];
            if (prev_index != -1) {
                result = result.substr(overlap[prev_index][last_index]);
            }
            mask ^= (1 << last_index);
            last_index = prev_index;
        }

        return result;
    }
};