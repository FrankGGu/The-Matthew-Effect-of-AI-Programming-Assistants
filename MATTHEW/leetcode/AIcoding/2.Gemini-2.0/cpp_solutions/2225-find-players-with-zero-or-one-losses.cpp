#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<vector<int>> findWinners(vector<vector<int>>& matches) {
        unordered_map<int, int> losses;
        for (auto& match : matches) {
            int winner = match[0];
            int loser = match[1];
            if (losses.find(winner) == losses.end()) {
                losses[winner] = 0;
            }
            losses[loser]++;
        }

        vector<int> zeroLoss;
        vector<int> oneLoss;

        for (auto& entry : losses) {
            if (entry.second == 0) {
                zeroLoss.push_back(entry.first);
            } else if (entry.second == 1) {
                oneLoss.push_back(entry.first);
            }
        }

        sort(zeroLoss.begin(), zeroLoss.end());
        sort(oneLoss.begin(), oneLoss.end());

        vector<vector<int>> result;
        result.push_back(zeroLoss);
        result.push_back(oneLoss);

        return result;
    }
};