class Solution:
    def minimizeTheDifference(self, mat: List[List[int]], target: int) -> int:
        possible_sums = {0}
        for row in mat:
            new_sums = set()
            min_row = min(row)
            max_possible = target + max(row)  # To limit the possible sums we track
            for num in row:
                for s in possible_sums:
                    new_sum = s + num
                    if new_sum <= max_possible:
                        new_sums.add(new_sum)
            possible_sums = new_sums
            if not possible_sums:
                break
        min_diff = float('inf')
        for s in possible_sums:
            diff = abs(s - target)
            if diff < min_diff:
                min_diff = diff
            if min_diff == 0:
                break
        return min_diff