class Solution:
    def numberOfArrays(self, differences: List[int], lower: int, upper: int) -> int:
        current = 0
        min_val = 0
        max_val = 0

        for diff in differences:
            current += diff
            if current < min_val:
                min_val = current
            if current > max_val:
                max_val = current

        lower_bound = lower - min_val
        upper_bound = upper - max_val

        if lower_bound > upper_bound:
            return 0
        else:
            return upper_bound - lower_bound + 1