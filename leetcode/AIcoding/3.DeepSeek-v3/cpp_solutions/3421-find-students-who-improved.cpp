#include <vector>
#include <string>
#include <unordered_map>
#include <set>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> findStudentsWhoImproved(vector<vector<int>>& scores) {
        unordered_map<int, vector<int>> studentScores;
        for (const auto& score : scores) {
            studentScores[score[0]].push_back(score[1]);
        }

        set<int> improvedStudents;
        for (auto& [student, scrs] : studentScores) {
            if (scrs.size() < 2) continue;
            bool improved = true;
            for (int i = 1; i < scrs.size(); ++i) {
                if (scrs[i] <= scrs[i-1]) {
                    improved = false;
                    break;
                }
            }
            if (improved) {
                improvedStudents.insert(student);
            }
        }

        vector<int> result(improvedStudents.begin(), improvedStudents.end());
        sort(result.begin(), result.end());
        return result;
    }
};