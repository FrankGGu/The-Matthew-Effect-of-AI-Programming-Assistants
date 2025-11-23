#include <iostream>
#include <vector>
#include <algorithm>
#include <climits>

using namespace std;

class Solution {
public:
    int findMax(int index, vector<int>& cookies, vector<int>& distribution, int k) {
        if (index == cookies.size()) {
            int maxCookies = 0;
            for (int i = 0; i < k; ++i) {
                maxCookies = max(maxCookies, distribution[i]);
            }
            return maxCookies;
        }

        int minMax = INT_MAX;
        for (int i = 0; i < k; ++i) {
            if (distribution[i] + cookies[index] >= minMax) continue;
            distribution[i] += cookies[index];
            minMax = min(minMax, findMax(index + 1, cookies, distribution, k));
            distribution[i] -= cookies[index];
        }
        return minMax;
    }

    int distributeCookies(vector<int>& cookies, int k) {
        vector<int> distribution(k, 0);
        return findMax(0, cookies, distribution, k);
    }
};