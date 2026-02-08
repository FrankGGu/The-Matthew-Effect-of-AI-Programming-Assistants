#include <vector>

using namespace std;

class Solution {
public:
    int largestCombination(vector<int>& candidates) {
        int ans = 0;
        for (int i = 0; i < 32; ++i) {
            int count = 0;
            for (int num : candidates) {
                if ((num >> i) & 1) {
                    count++;
                }
            }
            ans = max(ans, count);
        }
        return ans;
    }
};