class Solution:
    def maxCompatibilitySum(self, students: List[List[int]], mentors: List[List[int]]) -> int:
        m = len(students)
        n = len(students[0]) if m > 0 else 0

        # Precompute the compatibility scores between all student-mentor pairs
        score = [[0]*m for _ in range(m)]
        for i in range(m):
            for j in range(m):
                s = 0
                for k in range(n):
                    if students[i][k] == mentors[j][k]:
                        s += 1
                score[i][j] = s

        max_score = 0
        used = [False] * m

        def backtrack(student_idx, current_score):
            nonlocal max_score
            if student_idx == m:
                max_score = max(max_score, current_score)
                return
            for mentor_idx in range(m):
                if not used[mentor_idx]:
                    used[mentor_idx] = True
                    backtrack(student_idx + 1, current_score + score[student_idx][mentor_idx])
                    used[mentor_idx] = False

        backtrack(0, 0)
        return max_score