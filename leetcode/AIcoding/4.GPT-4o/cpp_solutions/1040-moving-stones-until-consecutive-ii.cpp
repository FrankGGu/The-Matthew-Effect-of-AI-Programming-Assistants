#include <vector>
#include <algorithm>
#include <set>
using namespace std;

class Solution {
public:
    vector<int> numMovesStonesII(vector<int>& stones) {
        sort(stones.begin(), stones.end());
        int n = stones.size();
        int maxMoves = max(stones[n-1] - stones[1] - n + 2, stones[n-2] - stones[0] - n + 2);
        int minMoves = 2;

        for (int i = 0; i < n; ++i) {
            if (stones[i] == i + stones[0]) {
                minMoves = 1;
                break;
            }
        }

        if (stones[0] == 1 && stones[n-1] == n) {
            minMoves = 0;
        }

        return {minMoves, maxMoves};
    }
};