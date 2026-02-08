#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int stoneGameVI(vector<int>& alice, vector<int>& bob) {
        vector<pair<int, int>> stones;
        for (int i = 0; i < alice.size(); ++i) {
            stones.push_back({alice[i] + bob[i], i});
        }
        sort(stones.begin(), stones.end(), greater<pair<int, int>>());

        int aliceScore = 0, bobScore = 0;
        for (int i = 0; i < stones.size(); ++i) {
            if (i % 2 == 0) {
                aliceScore += alice[stones[i].second];
            } else {
                bobScore += bob[stones[i].second];
            }
        }

        if (aliceScore > bobScore) return 1;
        else if (bobScore > aliceScore) return -1;
        else return 0;
    }
};