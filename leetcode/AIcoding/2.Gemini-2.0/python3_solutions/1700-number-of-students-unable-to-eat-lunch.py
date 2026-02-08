class Solution:
    def countStudents(self, students: List[int], sandwiches: List[int]) -> int:
        count_zero = students.count(0)
        count_one = len(students) - count_zero

        for sandwich in sandwiches:
            if sandwich == 0 and count_zero > 0:
                count_zero -= 1
            elif sandwich == 1 and count_one > 0:
                count_one -= 1
            else:
                break

        return count_zero + count_one