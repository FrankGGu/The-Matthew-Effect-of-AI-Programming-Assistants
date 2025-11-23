#include <vector>
#include <numeric>

using namespace std;

class Solution {
public:
    vector<int> maximumBobPoints(int numArrows, vector<int>& aliceArrows) {
        int maxPoints = -1;
        vector<int> bestBob(12, 0);

        for (int mask = 0; mask < (1 << 12); ++mask) {
            int currentArrows = numArrows;
            vector<int> currentBob(12, 0);
            int currentPoints = 0;

            for (int i = 0; i < 12; ++i) {
                if ((mask >> i) & 1) {
                    if (currentArrows > aliceArrows[i]) {
                        currentBob[i] = aliceArrows[i] + 1;
                        currentArrows -= currentBob[i];
                        currentPoints += i;
                    } else {
                        currentPoints = -1;
                        break;
                    }
                }
            }

            if (currentPoints > maxPoints) {
                maxPoints = currentPoints;
                bestBob = currentBob;
                bestBob[0] += currentArrows;
            } else if (currentPoints == maxPoints && currentPoints != -1) {
                vector<int> tempBob = currentBob;
                tempBob[0] += currentArrows;
                if(std::accumulate(tempBob.begin(), tempBob.end(), 0) > std::accumulate(bestBob.begin(), bestBob.end(), 0)){
                    bestBob = tempBob;
                }
            }
        }

        return bestBob;
    }
};