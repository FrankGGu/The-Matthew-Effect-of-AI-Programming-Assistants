#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int bestClosingTime(string customers) {
        int n = customers.size();
        int minPenalty = n;
        int bestTime = 0;
        int currentPenalty = 0;

        for (int i = 0; i < n; ++i) {
            if (customers[i] == 'Y') {
                currentPenalty--;
            } else {
                currentPenalty++;
            }

            if (currentPenalty < minPenalty) {
                minPenalty = currentPenalty;
                bestTime = i + 1;
            }
        }

        return bestTime;
    }
};