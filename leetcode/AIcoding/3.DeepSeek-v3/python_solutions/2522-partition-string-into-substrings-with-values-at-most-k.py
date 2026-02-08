class Solution:
    def minimumPartition(self, s: str, k: int) -> int:
        n = len(s)
        res = 0
        current = 0
        for c in s:
            num = int(c)
            if num > k:
                return -1
            current = current * 10 + num
            if current > k:
                res += 1
                current = num
        return res + 1