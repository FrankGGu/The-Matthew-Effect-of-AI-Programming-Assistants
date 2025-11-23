class Solution:
    def findStudents(self, scores: List[int], bonuses: List[int]) -> List[int]:
        improved_students = []
        for i in range(len(scores)):
            if scores[i] + bonuses[i] > 100:
                improved_students.append(i)
        return improved_students