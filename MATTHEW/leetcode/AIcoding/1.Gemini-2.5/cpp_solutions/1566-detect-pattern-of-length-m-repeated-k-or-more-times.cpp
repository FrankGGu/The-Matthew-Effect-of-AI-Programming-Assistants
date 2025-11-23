#include <vector>

class Solution {
public:
    bool containsPattern(std::vector<int>& arr, int m, int k) {
        int n = arr.size();
        if (m * k > n) {
            return false;
        }

        int count = 0;
        for (int i = 0; i + m < n; ++i) {
            if (arr[i] == arr[i + m]) {
                count++;
            } else {
                count = 0;
            }
            if (count == m * (k - 1)) {
                return true;
            }
        }

        return false;
    }
};