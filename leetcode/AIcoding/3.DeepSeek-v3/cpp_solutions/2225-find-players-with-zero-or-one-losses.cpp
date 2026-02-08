class Solution {
public:
    vector<vector<int>> findWinners(vector<vector<int>>& matches) {
        unordered_map<int, int> losses;
        for (const auto& match : matches) {
            int winner = match[0], loser = match[1];
            if (losses.find(winner) == losses.end()) {
                losses[winner] = 0;
            }
            losses[loser]++;
        }

        vector<int> zeroLoss, oneLoss;
        for (const auto& [player, lossCount] : losses) {
            if (lossCount == 0) {
                zeroLoss.push_back(player);
            } else if (lossCount == 1) {
                oneLoss.push_back(player);
            }
        }

        sort(zeroLoss.begin(), zeroLoss.end());
        sort(oneLoss.begin(), oneLoss.end());

        return {zeroLoss, oneLoss};
    }
};