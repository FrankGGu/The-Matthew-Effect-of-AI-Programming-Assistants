class Solution {
public:
    int maxStudents(vector<vector<char>>& seats) {
        int m = seats.size(), n = seats[0].size();
        vector<int> dp(1 << n, 0);

        for (int i = 0; i < m; ++i) {
            vector<int> new_dp(1 << n, 0);
            for (int j = 0; j < (1 << n); ++j) {
                if (dp[j] == 0 && j != 0) continue;
                for (int k = 0; k < (1 << n); ++k) {
                    if (canPlace(seats[i], k, j, n)) {
                        new_dp[k] = max(new_dp[k], dp[j] + countBits(k));
                    }
                }
            }
            dp = new_dp;
        }

        return *max_element(dp.begin(), dp.end());
    }

private:
    bool canPlace(const vector<char>& row, int mask, int prevMask, int n) {
        for (int j = 0; j < n; ++j) {
            if ((mask & (1 << j)) != 0) {
                if (row[j] == '#' || (j > 0 && (mask & (1 << (j - 1))) != 0) || (prevMask & (1 << j)) != 0) {
                    return false;
                }
            }
        }
        return true;
    }

    int countBits(int mask) {
        int count = 0;
        while (mask) {
            count += mask & 1;
            mask >>= 1;
        }
        return count;
    }
};