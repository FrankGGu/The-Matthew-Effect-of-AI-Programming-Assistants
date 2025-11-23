#include <vector>

using namespace std;

class Solution {
public:
    bool containsPattern(vector<int>& arr, int m, int k) {
        int n = arr.size();
        for (int i = 0; i <= n - m * k; ++i) {
            bool match = true;
            for (int j = 1; j < k; ++j) {
                for (int l = 0; l < m; ++l) {
                    if (arr[i + l] != arr[i + j * m + l]) {
                        match = false;
                        break;
                    }
                }
                if (!match) break;
            }
            if (match) return true;
        }
        return false;
    }
};