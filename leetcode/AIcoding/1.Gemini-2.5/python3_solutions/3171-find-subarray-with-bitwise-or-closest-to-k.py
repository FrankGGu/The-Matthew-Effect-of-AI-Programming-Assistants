class Solution:
    def closestToTarget(self, arr: list[int], target: int) -> int:
        min_diff = float('inf')

        current_ors = set()

        for num in arr:
            new_ors = {num}

            for prev_or_sum in current_ors:
                new_ors.add(prev_or_sum | num)

            current_ors = new_ors

            for or_sum in current_ors:
                min_diff = min(min_diff, abs(or_sum - target))

        return min_diff