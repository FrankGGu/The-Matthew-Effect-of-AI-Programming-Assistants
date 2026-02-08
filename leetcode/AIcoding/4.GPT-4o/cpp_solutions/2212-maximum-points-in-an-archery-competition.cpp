#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> maxPoints(int n, vector<int>& alice) {
        vector<int> result(11, 0);
        vector<int> best(11, 0);
        int maxScore = 0;

        for (int i = 0; i < 11; ++i) {
            if (alice[i] < n) {
                int pointsNeeded = alice[i] + 1;
                int pointsUsed = pointsNeeded;
                vector<int> temp = best;
                temp[i] = pointsUsed;

                for (int j = 0; j < 11 && pointsUsed <= n; ++j) {
                    if (j != i && pointsUsed + alice[j] + 1 <= n) {
                        pointsUsed += alice[j] + 1;
                        temp[j] = alice[j] + 1;
                    }
                }

                int score = 0;
                for (int j = 0; j < 11; ++j) {
                    if (temp[j] > 0) {
                        score += j;
                    }
                }

                if (score > maxScore) {
                    maxScore = score;
                    best = temp;
                }
            }
        }

        for (int i = 0; i < 11; ++i) {
            result[i] = best[i];
        }

        return result;
    }
};