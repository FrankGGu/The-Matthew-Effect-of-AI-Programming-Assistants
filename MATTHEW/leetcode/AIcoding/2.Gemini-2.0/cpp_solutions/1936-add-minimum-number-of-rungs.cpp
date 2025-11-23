#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int addRungs(vector<int>& rungs, int dist) {
        int count = 0;
        int current = 0;
        for (int rung : rungs) {
            if (rung - current > dist) {
                count += (rung - current - 1) / dist;
            }
            current = rung;
        }
        return count;
    }
};