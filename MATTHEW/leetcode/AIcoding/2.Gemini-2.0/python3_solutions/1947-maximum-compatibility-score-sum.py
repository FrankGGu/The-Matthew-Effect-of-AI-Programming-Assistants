class Solution:
    def maxCompatibilitySum(self, students: list[list[int]], mentors: list[list[int]]) -> int:
        n = len(students)
        m = len(mentors)
        max_score = 0

        def calculate_score(student, mentor):
            score = 0
            for i in range(len(student)):
                if student[i] == mentor[i]:
                    score += 1
            return score

        def solve(student_idx, used_mentors, current_score):
            nonlocal max_score
            if student_idx == n:
                max_score = max(max_score, current_score)
                return

            for mentor_idx in range(m):
                if mentor_idx not in used_mentors:
                    new_used_mentors = set(used_mentors)
                    new_used_mentors.add(mentor_idx)
                    solve(student_idx + 1, new_used_mentors, current_score + calculate_score(students[student_idx], mentors[mentor_idx]))

        solve(0, set(), 0)
        return max_score