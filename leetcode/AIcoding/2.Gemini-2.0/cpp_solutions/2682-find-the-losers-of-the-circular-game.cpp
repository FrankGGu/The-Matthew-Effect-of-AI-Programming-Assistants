#include <vector>

using namespace std;

class Solution {
public:
    vector<int> circularGameLosers(int n, int k) {
        vector<bool> hasBall(n, false);
        hasBall[0] = true;
        int current = 0;
        int multiplier = 1;
        while (true) {
            int next = (current + multiplier * k) % n;
            if (hasBall[next]) {
                break;
            }
            hasBall[next] = true;
            current = next;
            multiplier++;
        }

        vector<int> losers;
        for (int i = 0; i < n; ++i) {
            if (!hasBall[i]) {
                losers.push_back(i + 1);
            }
        }

        return losers;
    }
};