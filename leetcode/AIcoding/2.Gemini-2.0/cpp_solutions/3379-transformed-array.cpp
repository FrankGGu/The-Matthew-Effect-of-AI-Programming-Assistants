#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> transformArray(vector<int>& arr) {
        int n = arr.size();
        if (n <= 2) return arr;

        vector<int> prev = arr;
        vector<int> curr(n);

        bool changed = true;
        while (changed) {
            changed = false;
            curr[0] = prev[0];
            curr[n - 1] = prev[n - 1];

            for (int i = 1; i < n - 1; ++i) {
                if (prev[i - 1] > prev[i] && prev[i + 1] > prev[i]) {
                    curr[i] = prev[i] - 1;
                    if (curr[i] != prev[i]) changed = true;
                } else if (prev[i - 1] < prev[i] && prev[i + 1] < prev[i]) {
                    curr[i] = prev[i] + 1;
                    if (curr[i] != prev[i]) changed = true;
                } else {
                    curr[i] = prev[i];
                }
            }
            prev = curr;
        }

        return arr;
    }
};