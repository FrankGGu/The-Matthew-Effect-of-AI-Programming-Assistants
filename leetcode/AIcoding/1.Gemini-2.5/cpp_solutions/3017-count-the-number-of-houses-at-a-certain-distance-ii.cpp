#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<long long> countOfPairs(int n, int x, int y) {
        x--; 
        y--; 
        vector<long long> ans(n, 0);
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                int dist1 = abs(i - j);
                int dist2 = abs(i - x) + abs(j - y) + 1;
                int dist3 = abs(i - y) + abs(j - x) + 1;
                int minDist = min({dist1, dist2, dist3});
                ans[minDist - 1] += 2;
            }
        }
        return ans;
    }
};