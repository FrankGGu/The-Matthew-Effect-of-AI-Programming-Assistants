#include <iostream>
#include <vector>
#include <unordered_set>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int flipgame(vector<int>& fronts, vector<int>& backs) {
        unordered_map<int, int> same;
        int n = fronts.size();
        for (int i = 0; i < n; ++i) {
            if (fronts[i] == backs[i]) {
                same[fronts[i]] = 1;
            }
        }
        int res = INT_MAX;
        for (int i = 0; i < n; ++i) {
            if (same.find(fronts[i]) == same.end()) {
                res = min(res, fronts[i]);
            }
            if (same.find(backs[i]) == same.end()) {
                res = min(res, backs[i]);
            }
        }
        return res == INT_MAX ? 0 : res;
    }
};