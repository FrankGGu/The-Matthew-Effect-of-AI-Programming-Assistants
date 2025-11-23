#include <iostream>
#include <vector>
#include <algorithm>
#include <cmath>

using namespace std;

class Solution {
public:
    int eliminateMaximum(vector<int>& dist, vector<int>& speed) {
        int n = dist.size();
        for (int i = 0; i < n; ++i) {
            dist[i] = ceil(static_cast<double>(dist[i]) / speed[i]);
        }
        sort(dist.begin(), dist.end());
        for (int i = 0; i < n; ++i) {
            if (dist[i] <= i) {
                return i;
            }
        }
        return n;
    }
};