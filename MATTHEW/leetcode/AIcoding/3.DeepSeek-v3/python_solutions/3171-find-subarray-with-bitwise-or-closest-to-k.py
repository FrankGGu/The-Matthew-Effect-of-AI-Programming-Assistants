class Solution:
    def closestToTarget(self, arr: List[int], target: int) -> int:
        ans = float('inf')
        current_or_sets = set()

        for num in arr:
            new_or_sets = {num}
            for val in current_or_sets:
                new_or_sets.add(val | num)
            for val in new_or_sets:
                ans = min(ans, abs(val - target))
            current_or_sets = new_or_sets

        return ans