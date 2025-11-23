#include <vector>
#include <string>
#include <algorithm>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<string> findRelativeRanks(vector<int>& score) {
        int n = score.size();
        vector<pair<int, int>> scores(n);
        for (int i = 0; i < n; ++i) {
            scores[i] = {score[i], i};
        }
        sort(scores.rbegin(), scores.rend());

        vector<string> result(n);
        for (int i = 0; i < n; ++i) {
            if (i == 0) result[scores[i].second] = "Gold Medal";
            else if (i == 1) result[scores[i].second] = "Silver Medal";
            else if (i == 2) result[scores[i].second] = "Bronze Medal";
            else result[scores[i].second] = to_string(i + 1);
        }
        return result;
    }
};