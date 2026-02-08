#include <iostream>
#include <vector>
#include <map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int winningPlayers(int n, vector<vector<int>>& pick) {
        map<int, int> scoreMap;
        for (const auto& p : pick) {
            int player = p[0];
            int point = p[1];
            scoreMap[player] += point;
        }

        vector<pair<int, int>> sortedScores(scoreMap.begin(), scoreMap.end());
        sort(sortedScores.begin(), sortedScores.end(), [](const pair<int, int>& a, const pair<int, int>& b) {
            return a.second > b.second;
        });

        int maxScore = sortedScores[0].second;
        int count = 0;

        for (const auto& s : sortedScores) {
            if (s.second == maxScore) {
                count++;
            } else {
                break;
            }
        }

        return count;
    }
};