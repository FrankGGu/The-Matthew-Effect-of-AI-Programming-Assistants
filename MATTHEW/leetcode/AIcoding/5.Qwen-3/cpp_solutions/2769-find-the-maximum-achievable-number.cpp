#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int theMaximumAchievableNumber(int k, int x) {
        int ans = 0;
        for (int i = 0; i < k; ++i) {
            ans += (1 << x);
        }
        return ans;
    }
};