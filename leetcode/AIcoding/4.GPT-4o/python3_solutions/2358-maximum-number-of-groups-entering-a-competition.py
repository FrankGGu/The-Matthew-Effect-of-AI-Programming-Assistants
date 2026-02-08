class Solution:
    def maxNumberOfGroups(self, grades: List[int]) -> int:
        n = len(grades)
        total_sum = 0
        group_count = 0

        while total_sum + (group_count + 1) <= n:
            group_count += 1
            total_sum += group_count

        return group_count