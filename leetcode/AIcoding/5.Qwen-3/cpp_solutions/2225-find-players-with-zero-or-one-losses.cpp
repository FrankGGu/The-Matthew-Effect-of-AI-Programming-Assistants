#include <iostream>
#include <vector>
#include <map>

using namespace std;

class Solution {
public:
    vector<vector<int>> findWinners(vector<vector<int>>& matches) {
        map<int, int> lossCount;
        for (const auto& match : matches) {
            int winner = match[0];
            int loser = match[1];
            lossCount[winner]++;
            lossCount[loser]++;
        }

        vector<int> zeroLoss;
        vector<int> oneLoss;

        for (const auto& pair : lossCount) {
            if (pair.second == 0) {
                zeroLoss.push_back(pair.first);
            } else if (pair.second == 1) {
                oneLoss.push_back(pair.first);
            }
        }

        return {zeroLoss, oneLoss};
    }
};