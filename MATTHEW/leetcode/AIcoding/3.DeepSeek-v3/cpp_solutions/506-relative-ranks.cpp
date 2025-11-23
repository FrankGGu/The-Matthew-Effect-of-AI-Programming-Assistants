#include <vector>
#include <string>
#include <algorithm>
#include <map>

using namespace std;

class Solution {
public:
    vector<string> findRelativeRanks(vector<int>& score) {
        vector<int> sorted_score = score;
        sort(sorted_score.begin(), sorted_score.end(), greater<int>());
        map<int, string> rank_map;

        for (int i = 0; i < sorted_score.size(); ++i) {
            if (i == 0) {
                rank_map[sorted_score[i]] = "Gold Medal";
            } else if (i == 1) {
                rank_map[sorted_score[i]] = "Silver Medal";
            } else if (i == 2) {
                rank_map[sorted_score[i]] = "Bronze Medal";
            } else {
                rank_map[sorted_score[i]] = to_string(i + 1);
            }
        }

        vector<string> result;
        for (int s : score) {
            result.push_back(rank_map[s]);
        }

        return result;
    }
};