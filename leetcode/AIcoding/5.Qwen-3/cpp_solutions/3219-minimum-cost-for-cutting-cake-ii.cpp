#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minCost(int n, int m, vector<int>& hcuts, vector<int>& vcuts) {
        sort(hcuts.begin(), hcuts.end());
        sort(vcuts.begin(), vcuts.end());

        int h = 0, v = 0;
        int hcount = 0, vcount = 0;
        int cost = 0;

        while (h < hcuts.size() || v < vcuts.size()) {
            if (h < hcuts.size() && (v >= vcuts.size() || hcuts[h] < vcuts[v])) {
                cost += (hcuts[h] - h) * (vcount + 1);
                h++;
                hcount++;
            } else {
                cost += (vcuts[v] - v) * (hcount + 1);
                v++;
                vcount++;
            }
        }

        return cost;
    }
};