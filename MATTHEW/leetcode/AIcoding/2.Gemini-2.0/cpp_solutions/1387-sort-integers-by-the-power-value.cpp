#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int getPower(int n) {
        int steps = 0;
        while (n != 1) {
            if (n % 2 == 0) {
                n /= 2;
            } else {
                n = 3 * n + 1;
            }
            steps++;
        }
        return steps;
    }

    int getKth(int lo, int hi, int k) {
        vector<pair<int, int>> powerValues;
        for (int i = lo; i <= hi; ++i) {
            powerValues.push_back({getPower(i), i});
        }

        sort(powerValues.begin(), powerValues.end());

        return powerValues[k - 1].second;
    }
};