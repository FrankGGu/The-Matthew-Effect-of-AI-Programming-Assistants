#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int flipgame(vector<int>& fronts, vector<int>& backs) {
        unordered_set<int> same;
        int n = fronts.size();
        for (int i = 0; i < n; ++i) {
            if (fronts[i] == backs[i]) {
                same.insert(fronts[i]);
            }
        }

        int min_val = INT_MAX;
        for (int i = 0; i < n; ++i) {
            if (same.find(fronts[i]) == same.end()) {
                min_val = min(min_val, fronts[i]);
            }
            if (same.find(backs[i]) == same.end()) {
                min_val = min(min_val, backs[i]);
            }
        }

        return (min_val == INT_MAX) ? 0 : min_val;
    }
};