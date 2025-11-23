class Solution {
public:
    bool canPartition(std::vector<std::vector<int>>& grid) {
        int M = grid.size();
        if (M == 0) return false;
        int N = grid[0].size();
        if (N == 0) return false;

        std::vector<std::vector<long long>> P(M + 1, std::vector<long long>(N + 1, 0));
        for (int i = 0; i < M; ++i) {
            for (int j = 0; j < N; ++j) {
                P[i + 1][j + 1] = grid[i][j] + P[i][j + 1] + P[i + 1][j] - P[i][j];
            }
        }

        long long totalSum = P[M][N];

        if (totalSum % 3 != 0) {
            return false;
        }
        long long targetSum = totalSum / 3;

        if (M >= 3) {
            for (int r1 = 1; r1 < M - 1; ++r1) {
                for (int r2 = r1 + 1; r2 < M; ++r2) {
                    long long sum1 = P[r1][N];
                    long long sum2 = P[r2][N] - P[r1][N];
                    long long sum3 = P[M][N] - P[r2][N];

                    if (sum1 == targetSum && sum2 == targetSum && sum3 == targetSum) {
                        return true;
                    }
                }
            }
        }

        if (N >= 3) {
            for (int c1 = 1; c1 < N - 1; ++c1) {
                for (int c2 = c1 + 1; c2 < N; ++c2) {
                    long long sum1 = P[M][c1];
                    long long sum2 = P[M][c2] - P[M][c1];
                    long long sum3 = P[M][N] - P[M][c2];

                    if (sum1 == targetSum && sum2 == targetSum && sum3 == targetSum) {
                        return true;
                    }
                }
            }
        }

        return false;
    }
};