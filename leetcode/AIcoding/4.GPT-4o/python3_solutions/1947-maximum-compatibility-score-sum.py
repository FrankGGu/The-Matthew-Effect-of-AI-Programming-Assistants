from itertools import permutations

class Solution:
    def maxCompatibilitySum(self, students: List[List[int]], mentors: List[List[int]]) -> int:
        def compatibility_score(student, mentor):
            return sum(s == m for s, m in zip(student, mentor))

        max_score = 0
        for perm in permutations(mentors):
            score = sum(compatibility_score(stu, ment) for stu, ment in zip(students, perm))
            max_score = max(max_score, score)

        return max_score