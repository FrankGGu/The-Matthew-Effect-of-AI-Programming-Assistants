class Solution:
    def closestToTarget(self, arr: List[int], target: int) -> int:
        res = float('inf')
        current_and = set()
        for num in arr:
            next_and = set()
            next_and.add(num)
            for val in current_and:
                next_and.add(val & num)
            for val in next_and:
                res = min(res, abs(val - target))
            current_and = next_and
        return res