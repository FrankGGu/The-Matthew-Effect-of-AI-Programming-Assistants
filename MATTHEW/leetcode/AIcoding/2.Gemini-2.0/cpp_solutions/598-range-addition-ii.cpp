#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxCount(int m, int n, vector<vector<int>>& ops) {
        int min_a = m;
        int min_b = n;

        for (auto& op : ops) {
            min_a = min(min_a, op[0]);
            min_b = min(min_b, op[1]);
        }

        return min_a * min_b;
    }
};