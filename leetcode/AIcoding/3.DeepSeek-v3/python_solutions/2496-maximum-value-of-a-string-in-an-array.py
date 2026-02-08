class Solution:
    def maximumValue(self, strs: List[str]) -> int:
        max_val = 0
        for s in strs:
            if s.isdigit():
                current = int(s)
            else:
                current = len(s)
            if current > max_val:
                max_val = current
        return max_val