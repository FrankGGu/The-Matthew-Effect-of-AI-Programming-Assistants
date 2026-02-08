class Solution:
    def callOut(self, students: list[str], call_list: list[str]) -> int:
        student_set = set(students)
        count = 0
        for name in call_list:
            if name in student_set:
                count += 1
        return count