#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int sellDiminishingValuedColoredBalls(int n, vector<int>& quantities) {
        long long total = 0;
        sort(quantities.begin(), quantities.end());
        for (int i = 0; i < quantities.size(); ++i) {
            total += static_cast<long long>(quantities[i]) * (n - i);
        }
        return static_cast<int>(total);
    }
};