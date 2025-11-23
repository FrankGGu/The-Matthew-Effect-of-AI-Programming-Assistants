#include <vector>
#include <map>
#include <set>
#include <algorithm>

class Solution {
public:
    std::vector<std::vector<int>> findTeachersUniqueSubjects(std::vector<std::vector<int>>& teachers) {
        std::map<int, std::set<int>> teacherSubjects;

        for (const auto& record : teachers) {
            int teacher_id = record[0];
            int subject_id = record[1];
            teacherSubjects[teacher_id].insert(subject_id);
        }

        std::vector<std::vector<int>> result;
        for (const auto& entry : teacherSubjects) {
            result.push_back({entry.first, static_cast<int>(entry.second.size())});
        }

        // The problem description doesn't explicitly state sorting requirements for output,
        // but LeetCode often expects results sorted by teacher_id.
        // If not required, this sort can be omitted.
        std::sort(result.begin(), result.end(), [](const std::vector<int>& a, const std::vector<int>& b) {
            return a[0] < b[0];
        });

        return result;
    }
};