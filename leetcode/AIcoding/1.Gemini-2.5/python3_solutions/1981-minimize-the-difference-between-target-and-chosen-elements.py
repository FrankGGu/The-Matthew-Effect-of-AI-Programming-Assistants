class Solution:
    def minimizeTheDifference(self, mat: list[list[int]], target: int) -> int:
        possible_sums = {0}

        for row in mat:
            next_possible_sums = set()
            for current_sum in possible_sums:
                for element in row:
                    next_possible_sums.add(current_sum + element)
            possible_sums = next_possible_sums

        min_diff = float('inf')
        for s in possible_sums:
            min_diff = min(min_diff, abs(s - target))

        return min_diff