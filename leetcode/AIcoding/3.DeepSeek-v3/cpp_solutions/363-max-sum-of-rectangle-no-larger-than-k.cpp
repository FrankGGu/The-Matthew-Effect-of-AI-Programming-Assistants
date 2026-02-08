#include <vector>
#include <set>
#include <climits>

using namespace std;

class Solution {
public:
    int maxSumSubmatrix(vector<vector<int>>& matrix, int k) {
        if (matrix.empty()) return 0;
        int rows = matrix.size(), cols = matrix[0].size();
        int res = INT_MIN;

        for (int l = 0; l < cols; ++l) {
            vector<int> sums(rows, 0);
            for (int r = l; r < cols; ++r) {
                for (int i = 0; i < rows; ++i) {
                    sums[i] += matrix[i][r];
                }

                set<int> accuSet;
                accuSet.insert(0);
                int currSum = 0, currMax = INT_MIN;
                for (int sum : sums) {
                    currSum += sum;
                    auto it = accuSet.lower_bound(currSum - k);
                    if (it != accuSet.end()) currMax = max(currMax, currSum - *it);
                    accuSet.insert(currSum);
                }
                res = max(res, currMax);
            }
        }
        return res;
    }
};