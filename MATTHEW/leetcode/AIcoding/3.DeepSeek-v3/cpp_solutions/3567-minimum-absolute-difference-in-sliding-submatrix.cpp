#include <vector>
#include <set>
#include <climits>

using namespace std;

class Solution {
public:
    int minimumDifferenceSubmatrix(vector<vector<int>>& matrix, int size) {
        int m = matrix.size();
        int n = matrix[0].size();
        int min_diff = INT_MAX;

        for (int i = 0; i <= m - size; ++i) {
            for (int j = 0; j <= n - size; ++j) {
                multiset<int> window;
                for (int x = i; x < i + size; ++x) {
                    for (int y = j; y < j + size; ++y) {
                        window.insert(matrix[x][y]);
                    }
                }
                auto it = window.begin();
                int prev = *it;
                ++it;
                for (; it != window.end(); ++it) {
                    min_diff = min(min_diff, *it - prev);
                    prev = *it;
                }
            }
        }
        return min_diff;
    }
};