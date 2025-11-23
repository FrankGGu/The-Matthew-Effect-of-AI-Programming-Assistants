#include <iostream>
#include <vector>
#include <map>

using namespace std;

class Solution {
public:
    vector<vector<int>> countUniqueSubjects(vector<vector<int>>& teachers) {
        map<int, int> subjectCount;
        for (const auto& teacher : teachers) {
            int teacherId = teacher[0];
            int subjectId = teacher[1];
            subjectCount[teacherId]++;
        }
        vector<vector<int>> result;
        for (const auto& pair : subjectCount) {
            result.push_back({pair.first, pair.second});
        }
        return result;
    }
};