class Solution:
    def sortTheStudents(self, score: list[list[int]], k: int) -> list[list[int]]:
        score.sort(key=lambda student: student[k], reverse=False)
        return score