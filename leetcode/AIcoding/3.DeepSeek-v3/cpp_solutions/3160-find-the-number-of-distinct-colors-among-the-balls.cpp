#include <vector>
#include <unordered_map>
#include <unordered_set>

using namespace std;

class Solution {
public:
    vector<int> queryResults(int limit, vector<vector<int>>& queries) {
        unordered_map<int, int> ballToColor;
        unordered_map<int, unordered_set<int>> colorToBalls;
        vector<int> result;

        for (const auto& query : queries) {
            int ball = query[0];
            int color = query[1];

            if (ballToColor.find(ball) != ballToColor.end()) {
                int oldColor = ballToColor[ball];
                colorToBalls[oldColor].erase(ball);
                if (colorToBalls[oldColor].empty()) {
                    colorToBalls.erase(oldColor);
                }
            }

            ballToColor[ball] = color;
            colorToBalls[color].insert(ball);

            result.push_back(colorToBalls.size());
        }

        return result;
    }
};