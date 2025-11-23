#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxChooseA(int n, vector<int>& banned, int minK, int maxK) {
        int count = 0;
        vector<bool> used(n + 1, false);
        for (int num : banned) {
            if (num >= 1 && num <= n) {
                used[num] = true;
            }
        }
        for (int i = 1; i <= n; ++i) {
            if (!used[i] && i >= minK && i <= maxK) {
                ++count;
            }
        }
        return count;
    }
};