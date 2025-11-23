class Solution {
public:
    int giveGem(vector<int>& gem, vector<vector<int>>& operations) {
        for (const auto& op : operations) {
            int x = op[0], y = op[1];
            int give = gem[x] / 2;
            gem[x] -= give;
            gem[y] += give;
        }
        int max_gem = *max_element(gem.begin(), gem.end());
        int min_gem = *min_element(gem.begin(), gem.end());
        return max_gem - min_gem;
    }
};