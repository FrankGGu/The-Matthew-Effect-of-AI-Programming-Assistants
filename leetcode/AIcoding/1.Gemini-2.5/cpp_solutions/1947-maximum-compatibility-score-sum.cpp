#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    int N; 
    std::vector<std::vector<int>> compatibility_scores; 
    std::vector<std::vector<int>> memo; 

    int calculate_pair_compatibility(const std::vector<int>& student_skills, const std::vector<int>& mentor_skills) {
        int score = 0;
        for (int i = 0; i < student_skills.size(); ++i) {
            if (student_skills[i] == mentor_skills[i]) {
                score++;
            }
        }
        return score;
    }

    int solve(int student_idx, int used_mentors_mask) {
        if (student_idx == N) {
            return 0;
        }

        if (memo[student_idx][used_mentors_mask] != -1) {
            return memo[student_idx][used_mentors_mask];
        }

        int max_current_score = 0;
        for (int mentor_idx = 0; mentor_idx < N; ++mentor_idx) {
            if (!((used_mentors_mask >> mentor_idx) & 1)) {
                int current_compatibility = compatibility_scores[student_idx][mentor_idx];

                max_current_score = std::max(max_current_score,
                                             current_compatibility + solve(student_idx + 1, used_mentors_mask | (1 << mentor_idx)));
            }
        }

        return memo[student_idx][used_mentors_mask] = max_current_score;
    }

    int maxCompatibilitySum(std::vector<std::vector<int>>& students, std::vector<std::vector<int>>& mentors) {
        N = students.size();

        compatibility_scores.resize(N, std::vector<int>(N));
        for (int i = 0; i < N; ++i) {
            for (int j = 0; j < N; ++j) {
                compatibility_scores[i][j] = calculate_pair_compatibility(students[i], mentors[j]);
            }
        }

        memo.resize(N, std::vector<int>(1 << N, -1));

        return solve(0, 0);
    }
};