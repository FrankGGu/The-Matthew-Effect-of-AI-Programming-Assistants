#include <vector>
#include <cmath>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumRounds(vector<int>& bamboo) {
        int n = bamboo.size();
        int rounds = 0;
        for (int i = 0; i < n; ++i) {
            if (bamboo[i] == 0) continue;

            int cuts = (bamboo[i] - 1) / 2 + 1;
            rounds += cuts;
        }
        return rounds;
    }
};