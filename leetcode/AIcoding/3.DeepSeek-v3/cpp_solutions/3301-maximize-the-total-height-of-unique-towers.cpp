#include <vector>
#include <algorithm>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int maximizeTowerHeights(vector<int>& heights) {
        sort(heights.begin(), heights.end());
        unordered_set<int> used;
        int total = 0;
        for (int h : heights) {
            int new_h = h;
            while (used.count(new_h)) {
                new_h++;
            }
            used.insert(new_h);
            total += new_h;
        }
        return total;
    }
};