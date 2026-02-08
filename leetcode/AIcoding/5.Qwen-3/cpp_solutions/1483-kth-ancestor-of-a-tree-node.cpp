#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

class Solution {
public:
    vector<int> getKthAncestor(int n, int k, vector<int>& queries) {
        vector<vector<int>> up(n, vector<int>(20, -1));

        for (int i = 0; i < n; ++i) {
            if (queries[i] != -1) {
                up[i][0] = queries[i];
            }
        }

        for (int j = 1; j < 20; ++j) {
            for (int i = 0; i < n; ++i) {
                if (up[i][j - 1] != -1) {
                    up[i][j] = up[up[i][j - 1]][j - 1];
                }
            }
        }

        vector<int> result;
        for (int i = 0; i < n; ++i) {
            int current = i;
            int step = k;
            for (int j = 0; j < 20 && step > 0; ++j) {
                if (step & 1) {
                    current = up[current][j];
                }
                step >>= 1;
            }
            result.push_back(current);
        }

        return result;
    }
};