class Solution:
    def closestToTarget(self, arr: list[int], target: int) -> int:
        n = len(arr)
        min_diff = float('inf')

        prev_ands = set()

        for i in range(n):
            new_ands = set()

            current_val = arr[i]
            new_ands.add(current_val)
            min_diff = min(min_diff, abs(current_val - target))

            for val in prev_ands:
                and_val = val & arr[i]
                new_ands.add(and_val)
                min_diff = min(min_diff, abs(and_val - target))

            if min_diff == 0:
                return 0

            prev_ands = new_ands

        return min_diff