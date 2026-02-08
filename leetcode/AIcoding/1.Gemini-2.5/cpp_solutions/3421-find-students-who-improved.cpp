#include <vector>

class Solution {
public:
    std::vector<int> findStudentsWhoImproved(std::vector<std::vector<int>>& scores) {
        std::vector<int> improvedStudents;
        for (const auto& student : scores) {
            // Assuming each inner vector is [student_id, initial_score, final_score]
            int student_id = student[0];
            int initial_score = student[1];
            int final_score = student[2];

            if (final_score > initial_score) {
                improvedStudents.push_back(student_id);
            }
        }
        return improvedStudents;
    }
};