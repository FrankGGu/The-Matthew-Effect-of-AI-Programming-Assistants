class Solution:
    def countStudents(self, students: list[int], sandwiches: list[int]) -> int:
        student_counts = [0, 0] 
        for student_pref in students:
            student_counts[student_pref] += 1

        for sandwich_type in sandwiches:
            if student_counts[sandwich_type] > 0:
                student_counts[sandwich_type] -= 1
            else:
                return sum(student_counts)

        return 0