#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int mostCommonResponse(vector<vector<int>>& responses) {
        unordered_map<int, int> counts;
        int maxCount = 0;
        int mostCommon = -1;

        for (const auto& response : responses) {
            for (int val : response) {
                counts[val]++;
                if (counts[val] > maxCount) {
                    maxCount = counts[val];
                    mostCommon = val;
                }
            }
        }

        return mostCommon;
    }
};