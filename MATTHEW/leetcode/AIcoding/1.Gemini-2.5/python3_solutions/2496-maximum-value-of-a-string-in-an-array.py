class Solution:
    def maximumValue(self, strs: list[str]) -> int:
        max_val = 0
        for s in strs:
            if s.isdigit():
                current_val = int(s)
            else:
                current_val = len(s)

            if current_val > max_val:
                max_val = current_val

        return max_val