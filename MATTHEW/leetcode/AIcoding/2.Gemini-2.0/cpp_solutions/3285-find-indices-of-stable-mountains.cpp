#include <vector>

using namespace std;

class Solution {
public:
    vector<int> findValleyPeakIndices(vector<int>& mountain) {
        int n = mountain.size();
        if (n < 3) return {-1, -1};

        for (int i = 1; i < n - 1; ++i) {
            if (mountain[i] <= mountain[i - 1] && mountain[i] <= mountain[i + 1]) {
                return {i - 1, i + 1};
            }
        }
        return {-1, -1};
    }
};