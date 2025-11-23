class Solution:
    def numberOfArrays(self, n: int, differences: List[int], lower: int, upper: int) -> int:
        min_val = 0
        max_val = 0
        curr = 0
        for diff in differences:
            curr += diff
            min_val = min(min_val, curr)
            max_val = max(max_val, curr)

        max_start = upper - max_val
        min_start = lower - min_val

        return max(0, max_start - min_start + 1)