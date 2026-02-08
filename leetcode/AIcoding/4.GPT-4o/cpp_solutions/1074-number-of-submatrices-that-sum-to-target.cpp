#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int numSubmatrixSumTarget(vector<vector<int>>& matrix, int target) {
        int row = matrix.size();
        int col = matrix[0].size();
        int count = 0;

        for (int left = 0; left < col; ++left) {
            vector<int> sum(row, 0);
            for (int right = left; right < col; ++right) {
                for (int i = 0; i < row; ++i) {
                    sum[i] += matrix[i][right];
                }

                unordered_map<int, int> sumCount;
                sumCount[0] = 1;
                int currSum = 0;

                for (int s : sum) {
                    currSum += s;
                    count += sumCount[currSum - target];
                    sumCount[currSum]++;
                }
            }
        }
        return count;
    }
};