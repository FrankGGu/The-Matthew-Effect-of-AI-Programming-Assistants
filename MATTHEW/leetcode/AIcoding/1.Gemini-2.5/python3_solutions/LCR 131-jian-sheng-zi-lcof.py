class Solution:
    def cutBamboo(self, bamboo_heights: list[int], target: int) -> int:
        total_operations = 0
        for height in bamboo_heights:
            current_height = height
            operations_for_this_bamboo = 0
            while current_height > target:
                current_height //= 2
                operations_for_this_bamboo += 1
            total_operations += operations_for_this_bamboo
        return total_operations