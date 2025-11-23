#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    bool containsPattern(const vector<int>& arr, int m, int k) {
        int n = arr.size();
        for (int i = 0; i + m * k <= n; ++i) {
            bool valid = true;
            for (int j = 1; j < k; ++j) {
                for (int p = 0; p < m; ++p) {
                    if (arr[i + j * m + p] != arr[i + p]) {
                        valid = false;
                        break;
                    }
                }
                if (!valid) break;
            }
            if (valid) return true;
        }
        return false;
    }
};