int N_global;
int M_global;
int max_compatibility_score_global;
int compatibility_matrix_global[8][8];

void backtrack_compatibility(int student_idx, int current_score, int visited_mentors_mask) {
    if (student_idx == N_global) {
        if (current_score > max_compatibility_score_global) {
            max_compatibility_score_global = current_score;
        }
        return;
    }

    for (int mentor_idx = 0; mentor_idx < N_global; ++mentor_idx) {
        if (!((visited_mentors_mask >> mentor_idx) & 1)) {
            visited_mentors_mask |= (1 << mentor_idx);

            backtrack_compatibility(student_idx + 1, current_score + compatibility_matrix_global[student_idx][mentor_idx], visited_mentors_mask);

            visited_mentors_mask &= ~(1 << mentor_idx);
        }
    }
}

int maxCompatibilitySum(int** students, int studentsSize, int* studentsColSize, int** mentors, int mentorsSize, int* mentorsColSize) {
    N_global = studentsSize;
    M_global = *studentsColSize;
    max_compatibility_score_global = 0;

    for (int i = 0; i < N_global; ++i) {
        for (int j = 0; j < N_global; ++j) {
            int current_pair_score = 0;
            for (int k = 0; k < M_global; ++k) {
                if (students[i][k] == mentors[j][k]) {
                    current_pair_score++;
                }
            }
            compatibility_matrix_global[i][j] = current_pair_score;
        }
    }

    backtrack_compatibility(0, 0, 0);

    return max_compatibility_score_global;
}