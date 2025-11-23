#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> fallingSquares(vector<vector<int>>& positions) {
        vector<pair<int, int>> heights;
        vector<int> ans;
        int maxHeight = 0;

        for (auto& pos : positions) {
            int left = pos[0];
            int side = pos[1];
            int right = left + side;

            int curHeight = 0;
            for (auto& h : heights) {
                if (max(left, h.first) < min(right, h.second)) {
                    curHeight = max(curHeight, h.second - h.first);
                }
            }
            curHeight += side;

            heights.push_back({left, left + side + curHeight - side});

            maxHeight = max(maxHeight, curHeight);
            ans.push_back(maxHeight);
        }

        return ans;
    }
};