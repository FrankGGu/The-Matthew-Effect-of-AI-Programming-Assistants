#include <vector>
#include <numeric>

class Solution {
public:
    bool equalSumGridPartitionII(std::vector<std::vector<int>>& grid) {
        int m = grid.size();
        if (m == 0) return false;
        int n = grid[0].size();
        if (n == 0) return false;

        std::vector<std::vector<long long>> pref(m + 1, std::vector<long long>(n + 1, 0));
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                pref[i + 1][j + 1] = grid[i][j] + pref[i][j + 1] + pref[i + 1][j] - pref[i][j];
            }
        }

        auto getSum = [&](int r1, int c1, int r2, int c2) {
            if (r1 > r2 || c1 > c2) return 0LL;
            return pref[r2 + 1][c2 + 1] - pref[r1][c2 + 1] - pref[r2 + 1][c1] + pref[r1][c1];
        };

        long long totalSum = getSum(0, 0, m - 1, n - 1);

        if (totalSum % 4 != 0) {
            return false;
        }
        long long target = totalSum / 4;

        // Case 1: One horizontal cut and one vertical cut (creates 4 rectangles)
        // Requires at least 2 rows and 2 columns
        if (m >= 2 && n >= 2) {
            for (int r = 0; r < m - 1; ++r) { // horizontal cut after row r
                for (int c = 0; c < n - 1; ++c) { // vertical cut after col c
                    long long p1 = getSum(0, 0, r, c);
                    long long p2 = getSum(0, c + 1, r, n - 1);
                    long long p3 = getSum(r + 1, 0, m - 1, c);
                    long long p4 = getSum(r + 1, c + 1, m - 1, n - 1);
                    if (p1 == target && p2 == target && p3 == target && p4 == target) {
                        return true;
                    }
                }
            }
        }

        // Case 2: Three horizontal cuts (creates 4 horizontal strips)
        // Requires at least 4 rows
        if (m >= 4) {
            for (int r1 = 0; r1 < m - 3; ++r1) { // last row of P1
                for (int r2 = r1 + 1; r2 < m - 2; ++r2) { // last row of P2
                    for (int r3 = r2 + 1; r3 < m - 1; ++r3) { // last row of P3
                        long long p1 = getSum(0, 0, r1, n - 1);
                        long long p2 = getSum(r1 + 1, 0, r2, n - 1);
                        long long p3 = getSum(r2 + 1, 0, r3, n - 1);
                        long long p4 = getSum(r3 + 1, 0, m - 1, n - 1);
                        if (p1 == target && p2 == target && p3 == target && p4 == target) {
                            return true;
                        }
                    }
                }
            }
        }

        // Case 3: Three vertical cuts (creates 4 vertical strips)
        // Requires at least 4 columns
        if (n >= 4) {
            for (int c1 = 0; c1 < n - 3; ++c1) { // last col of P1
                for (int c2 = c1 + 1; c2 < n - 2; ++c2) { // last col of P2
                    for (int c3 = c2 + 1; c3 < n - 1; ++c3) { // last col of P3
                        long long p1 = getSum(0, 0, m - 1, c1);
                        long long p2 = getSum(0, c1 + 1, m - 1, c2);
                        long long p3 = getSum(0, c2 + 1, m - 1, c3);
                        long long p4 = getSum(0, c3 + 1, m - 1, n - 1);
                        if (p1 == target && p2 == target && p3 == target && p4 == target) {
                            return true;
                        }
                    }
                }
            }
        }

        // Case 4: Two horizontal cuts and one vertical cut
        // Grid divided into 3 horizontal strips, one strip is split vertically
        // Requires at least 3 rows and 2 columns
        if (m >= 3 && n >= 2) {
            for (int r1 = 0; r1 < m - 2; ++r1) { // first horizontal cut after r1
                for (int r2 = r1 + 1; r2 < m - 1; ++r2) { // second horizontal cut after r2
                    for (int c = 0; c < n - 1; ++c) { // vertical cut after c
                        // Subcase A1: Split top strip (0..r1)
                        long long p1_A1 = getSum(0, 0, r1, c);
                        long long p2_A1 = getSum(0, c + 1, r1, n - 1);
                        long long p3_A1 = getSum(r1 + 1, 0, r2, n - 1);
                        long long p4_A1 = getSum(r2 + 1, 0, m - 1, n - 1);
                        if (p1_A1 == target && p2_A1 == target && p3_A1 == target && p4_A1 == target) {
                            return true;
                        }

                        // Subcase A2: Split middle strip (r1+1..r2)
                        long long p1_A2 = getSum(0, 0, r1, n - 1);
                        long long p2_A2 = getSum(r1 + 1, 0, r2, c);
                        long long p3_A2 = getSum(r1 + 1, c + 1, r2, n - 1);
                        long long p4_A2 = getSum(r2 + 1, 0, m - 1, n - 1);
                        if (p1_A2 == target && p2_A2 == target && p3_A2 == target && p4_A2 == target) {
                            return true;
                        }

                        // Subcase A3: Split bottom strip (r2+1..m-1)
                        long long p1_A3 = getSum(0, 0, r1, n - 1);
                        long long p2_A3 = getSum(r1 + 1, 0, r2, n - 1);
                        long long p3_A3 = getSum(r2 + 1, 0, m - 1, c);
                        long long p4_A3 = getSum(r2 + 1, c + 1, m - 1, n - 1);
                        if (p1_A3 == target && p2_A3 == target && p3_A3 == target && p4_A3 == target) {
                            return true;
                        }
                    }
                }
            }
        }

        // Case 5: Two vertical cuts and one horizontal cut
        // Grid divided into 3 vertical strips, one strip is split horizontally
        // Requires at least 3 columns and 2 rows
        if (n >= 3 && m >= 2) {
            for (int c1 = 0; c1 < n - 2; ++c1) { // first vertical cut after c1
                for (int c2 = c1 + 1; c2 < n - 1; ++c2) { // second vertical cut after c2
                    for (int r = 0; r < m - 1; ++r) { // horizontal cut after r
                        // Subcase B1: Split left strip (0..c1)
                        long long p1_B1 = getSum(0, 0, r, c1);
                        long long p2_B1 = getSum(r + 1, 0, m - 1, c1);
                        long long p3_B1 = getSum(0, c1 + 1, m - 1, c2);
                        long long p4_B1 = getSum(0, c2 + 1, m - 1, n - 1);
                        if (p1_B1 == target && p2_B1 == target && p3_B1 == target && p4_B1 == target) {
                            return true;
                        }

                        // Subcase B2: Split middle strip (c1+1..c2)
                        long long p1_B2 = getSum(0, 0, m - 1, c1);
                        long long p2_B2 = getSum(0, c1 + 1, r, c2);
                        long long p3_B2 = getSum(r + 1, c1 + 1, m - 1, c2);
                        long long p4_B2 = getSum(0, c2 + 1, m - 1, n - 1);
                        if (p1_B2 == target && p2_B2 == target && p3_B2 == target && p4_B2 == target) {
                            return true;
                        }

                        // Subcase B3: Split right strip (c2+1..n-1)
                        long long p1_B3 = getSum(0, 0, m - 1, c1);
                        long long p2_B3 = getSum(0, c1 + 1, m - 1, c2);
                        long long p3_B3 = getSum(0, c2 + 1, r, n - 1);
                        long long p4_B3 = getSum(r + 1, c2 + 1, m - 1, n - 1);
                        if (p1_B3 == target && p2_B3 == target && p3_B3 == target && p4_B3 == target) {
                            return true;
                        }
                    }
                }
            }
        }

        return false;
    }
};