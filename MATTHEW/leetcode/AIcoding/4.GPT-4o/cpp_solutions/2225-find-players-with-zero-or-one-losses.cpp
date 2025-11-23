#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

vector<vector<int>> findWinners(vector<vector<int>>& matches) {
    unordered_map<int, int> lossCount;
    for (const auto& match : matches) {
        lossCount[match[0]]; // initialize winner
        lossCount[match[1]]++; // increment loss for loser
    }

    vector<int> zeroLosses, oneLoss;
    for (const auto& entry : lossCount) {
        if (entry.second == 0) {
            zeroLosses.push_back(entry.first);
        } else if (entry.second == 1) {
            oneLoss.push_back(entry.first);
        }
    }

    sort(zeroLosses.begin(), zeroLosses.end());
    sort(oneLoss.begin(), oneLoss.end());

    return {zeroLosses, oneLoss};
}