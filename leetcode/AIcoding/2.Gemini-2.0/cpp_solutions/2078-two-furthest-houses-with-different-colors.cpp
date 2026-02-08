#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxDistance(vector<int>& colors) {
        int n = colors.size();
        int max_dist = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = n - 1; j > i; --j) {
                if (colors[i] != colors[j]) {
                    max_dist = max(max_dist, j - i);
                    break;
                }
            }
        }
        return max_dist;
    }
};