#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<vector<int>> subjectCount(vector<vector<int>>& teacher_subjects) {
        unordered_map<int, unordered_set<int>> teacherToSubjects;

        for (const auto& entry : teacher_subjects) {
            int teacher = entry[0];
            int subject = entry[1];
            teacherToSubjects[teacher].insert(subject);
        }

        vector<vector<int>> result;
        for (const auto& pair : teacherToSubjects) {
            result.push_back({pair.first, static_cast<int>(pair.second.size())});
        }

        return result;
    }
};