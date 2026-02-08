#include <iostream>
#include <vector>
#include <climits>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long maximumValueSum(vector<int>& board) {
        int n = board.size();
        vector<long long> rowMax(n, 0);
        vector<long long> colMax(n, 0);

        for (int i = 0; i < n; ++i) {
            long long maxVal = INT_MIN;
            for (int j = 0; j < n; ++j) {
                maxVal = max(maxVal, (long long)board[i * n + j]);
            }
            rowMax[i] = maxVal;
        }

        for (int j = 0; j < n; ++j) {
            long long maxVal = INT_MIN;
            for (int i = 0; i < n; ++i) {
                maxVal = max(maxVal, (long long)board[i * n + j]);
            }
            colMax[j] = maxVal;
        }

        sort(rowMax.begin(), rowMax.end(), greater<long long>());
        sort(colMax.begin(), colMax.end(), greater<long long>());

        return rowMax[0] + rowMax[1] + rowMax[2] + colMax[0] + colMax[1] + colMax[2];
    }
};