#include <vector>

using namespace std;

class Solution {
public:
    int giveGem(vector<int>& gem, vector<vector<int>>& operations) {
        for (auto& op : operations) {
            int x = op[0];
            int y = op[1];
            int give = gem[x] / 2;
            gem[x] -= give;
            gem[y] += give;
        }

        int max_gem = gem[0];
        int min_gem = gem[0];
        for (int g : gem) {
            max_gem = max(max_gem, g);
            min_gem = min(min_gem, g);
        }

        return max_gem - min_gem;
    }
};