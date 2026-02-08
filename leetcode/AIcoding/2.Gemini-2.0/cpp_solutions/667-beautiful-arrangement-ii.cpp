#include <vector>

using namespace std;

class Solution {
public:
    vector<int> constructArray(int n, int k) {
        vector<int> result(n);
        int left = 1, right = k + 1;
        for (int i = 0; i <= k; ++i) {
            if (i % 2 == 0) {
                result[i] = left++;
            } else {
                result[i] = right--;
            }
        }
        for (int i = k + 1; i < n; ++i) {
            result[i] = i + 1;
        }
        return result;
    }
};