from typing import List

class Solution:
    def findStudentsWhoImproved(self, students: List[List[int]]) -> List[int]:
        improved_students_ids = []
        for student_record in students:
            student_id = student_record[0]
            score1 = student_record[1]
            score2 = student_record[2]
            if score2 > score1:
                improved_students_ids.append(student_id)
        return improved_students_ids