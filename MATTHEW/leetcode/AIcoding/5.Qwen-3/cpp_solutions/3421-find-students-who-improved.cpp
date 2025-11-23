#include <iostream>
#include <vector>
#include <map>

using namespace std;

class Solution {
public:
    vector<vector<int>> findStudentsWhoImproved(vector<vector<int>>& reports) {
        map<int, int> bestScore;
        for (const auto& report : reports) {
            int studentId = report[0];
            int score = report[1];
            if (bestScore.find(studentId) == bestScore.end() || score > bestScore[studentId]) {
                bestScore[studentId] = score;
            }
        }

        vector<vector<int>> result;
        for (const auto& pair : bestScore) {
            result.push_back({pair.first});
        }

        return result;
    }
};