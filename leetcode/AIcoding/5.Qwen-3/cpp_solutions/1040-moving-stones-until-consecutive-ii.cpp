#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int numMovesStonesII(vector<int>& stones) {
        int n = stones.size();
        sort(stones.begin(), stones.end());

        int left = 0;
        int right = 0;
        int minMoves = INT_MAX;

        while (right < n) {
            while (stones[right] - stones[left] >= n) {
                left++;
            }
            if (right - left + 1 == n - 1) {
                minMoves = min(minMoves, 1);
            } else if (right - left + 1 == n - 2) {
                minMoves = min(minMoves, 2);
            }
            right++;
        }

        return minMoves;
    }
};