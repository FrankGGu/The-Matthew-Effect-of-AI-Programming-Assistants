#include <vector>
#include <numeric>

using namespace std;

class Solution {
public:
    vector<int> giveGem(vector<int>& gem, vector<vector<int>>& operations) {
        for (const auto& op : operations) {
            int x = op[0];
            int y = op[1];
            int half = gem[x] / 2;
            gem[x] -= half;
            gem[y] += half;
        }

        int min_val = gem[0];
        int max_val = gem[0];
        for (int i = 1; i < gem.size(); ++i) {
            min_val = min(min_val, gem[i]);
            max_val = max(max_val, gem[i]);
        }

        return {max_val - min_val};
    }
};