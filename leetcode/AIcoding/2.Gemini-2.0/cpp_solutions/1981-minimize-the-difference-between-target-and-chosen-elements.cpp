#include <vector>
#include <numeric>
#include <algorithm>
#include <climits>

using namespace std;

class Solution {
public:
    int minimizeTheDifference(vector<vector<int>>& mat, int target) {
        int m = mat.size();
        int n = mat[0].size();

        vector<bool> possibleSums(5001, false);
        possibleSums[0] = true;

        for (int i = 0; i < m; ++i) {
            vector<bool> nextPossibleSums(5001, false);
            for (int num : mat[i]) {
                for (int j = 0; j < 5001 - num; ++j) {
                    if (possibleSums[j]) {
                        nextPossibleSums[j + num] = true;
                    }
                }
            }
            possibleSums = nextPossibleSums;
        }

        int minDiff = INT_MAX;
        for (int i = 0; i < 5001; ++i) {
            if (possibleSums[i]) {
                minDiff = min(minDiff, abs(i - target));
            }
        }

        return minDiff;
    }
};