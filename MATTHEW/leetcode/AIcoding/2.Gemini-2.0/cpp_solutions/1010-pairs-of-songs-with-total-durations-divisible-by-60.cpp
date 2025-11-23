#include <vector>

using namespace std;

class Solution {
public:
    int numPairsDivisibleBy60(vector<int>& time) {
        vector<int> count(60, 0);
        int ans = 0;
        for (int t : time) {
            ans += count[(60 - t % 60) % 60];
            count[t % 60]++;
        }
        return ans;
    }
};