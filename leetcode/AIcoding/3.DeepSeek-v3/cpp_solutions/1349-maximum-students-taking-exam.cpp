class Solution {
public:
    int maxStudents(vector<vector<char>>& seats) {
        int m = seats.size();
        int n = seats[0].size();
        vector<int> dp(1 << n, 0);

        for (int i = m - 1; i >= 0; --i) {
            vector<int> new_dp(1 << n, 0);
            for (int prev_mask = 0; prev_mask < (1 << n); ++prev_mask) {
                for (int curr_mask = 0; curr_mask < (1 << n); ++curr_mask) {
                    bool valid = true;
                    int count = 0;
                    for (int j = 0; j < n; ++j) {
                        if (curr_mask & (1 << j)) {
                            if (seats[i][j] == '#') {
                                valid = false;
                                break;
                            }
                            if (j > 0 && (curr_mask & (1 << (j - 1)))) {
                                valid = false;
                                break;
                            }
                            if (j < n - 1 && (curr_mask & (1 << (j + 1)))) {
                                valid = false;
                                break;
                            }
                            if (j > 0 && (prev_mask & (1 << (j - 1)))) {
                                valid = false;
                                break;
                            }
                            if (j < n - 1 && (prev_mask & (1 << (j + 1)))) {
                                valid = false;
                                break;
                            }
                            count++;
                        }
                    }
                    if (valid) {
                        new_dp[curr_mask] = max(new_dp[curr_mask], dp[prev_mask] + count);
                    }
                }
            }
            dp = move(new_dp);
        }

        return *max_element(dp.begin(), dp.end());
    }
};