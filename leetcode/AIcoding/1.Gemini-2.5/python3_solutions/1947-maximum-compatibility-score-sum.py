from typing import List

class Solution:
    def maxCompatibilitySum(self, mentors: List[List[int]], students: List[List[int]]) -> int:
        m = len(mentors)
        n = len(students)

        compat_scores = [[0] * n for _ in range(m)]
        for i in range(m):
            for j in range(n):
                score = 0
                for k in range(len(mentors[i])):
                    if mentors[i][k] == students[j][k]:
                        score += 1
                compat_scores[i][j] = score

        max_total_score = 0

        def backtrack(mentor_idx, student_mask, current_score_sum):
            nonlocal max_total_score

            if mentor_idx == m:
                max_total_score = max(max_total_score, current_score_sum)
                return

            for student_j_idx in range(n):
                if not (student_mask & (1 << student_j_idx)):
                    new_score_sum = current_score_sum + compat_scores[mentor_idx][student_j_idx]
                    new_student_mask = student_mask | (1 << student_j_idx)
                    backtrack(mentor_idx + 1, new_student_mask, new_score_sum)

        backtrack(0, 0, 0)

        return max_total_score