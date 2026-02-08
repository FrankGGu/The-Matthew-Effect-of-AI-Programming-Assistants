#include <vector>

using namespace std;

class Solution {
public:
    double getProbability(vector<int>& balls) {
        int n = balls.size();
        int totalBalls = 0;
        for (int ball : balls) {
            totalBalls += ball;
        }
        int half = totalBalls / 2;

        vector<vector<double>> comb(totalBalls + 1, vector<double>(totalBalls + 1, 0.0));
        for (int i = 0; i <= totalBalls; ++i) {
            comb[i][0] = comb[i][i] = 1.0;
            for (int j = 1; j < i; ++j) {
                comb[i][j] = comb[i - 1][j - 1] + comb[i - 1][j];
            }
        }

        double favorable = 0.0;
        double total = comb[totalBalls][half];

        function<void(int, int, int, int, double)> solve = 
            [&](int idx, int balls1, int distinct1, int distinct2, double prob) {
            if (idx == n) {
                if (balls1 == half && distinct1 == distinct2) {
                    favorable += prob;
                }
                return;
            }

            for (int i = 0; i <= balls[idx]; ++i) {
                if (balls1 + i <= half) {
                    double newProb = prob * comb[balls[idx]][i];
                    solve(idx + 1, balls1 + i, distinct1 + (i > 0), distinct2 + (balls[idx] - i > 0), newProb);
                }
            }
        };

        solve(0, 0, 0, 0, 1.0);

        return favorable / total;
    }
};