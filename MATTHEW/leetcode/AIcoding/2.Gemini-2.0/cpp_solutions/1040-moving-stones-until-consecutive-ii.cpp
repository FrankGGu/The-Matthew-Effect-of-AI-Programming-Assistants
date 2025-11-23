#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> numMovesStonesII(vector<int>& stones) {
        sort(stones.begin(), stones.end());
        int n = stones.size();
        int max_moves = max(stones[n - 1] - stones[1] - n + 2, stones[n - 2] - stones[0] - n + 2);
        int min_moves = max_moves;
        int j = 0;
        for (int i = 0; i < n; ++i) {
            while (j < n && stones[j] - stones[i] + 1 <= n) {
                ++j;
            }
            int count = j - i;
            if (count == n - 1 && stones[j - 1] - stones[i] + 1 == n - 1) {
                min_moves = min(min_moves, 2);
            } else {
                min_moves = min(min_moves, n - count);
            }
        }
        return {min_moves, max_moves};
    }
};