#include <iostream>
#include <vector>
#include <queue>
#include <climits>

using namespace std;

class Solution {
public:
    int shortestSubarray(int n, int m, vector<vector<int>>& a, int k) {
        vector<vector<int>> prefix(n + 1, vector<int>(m, 0));
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < m; ++j) {
                prefix[i + 1][j] = prefix[i][j] | a[i][j];
            }
        }

        int result = INT_MAX;
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j <= n; ++j) {
                int or_val = 0;
                for (int x = 0; x < m; ++x) {
                    or_val |= prefix[j][x] ^ prefix[i][x];
                }
                if (or_val >= k) {
                    result = min(result, j - i);
                    break;
                }
            }
        }

        return result == INT_MAX ? -1 : result;
    }
};