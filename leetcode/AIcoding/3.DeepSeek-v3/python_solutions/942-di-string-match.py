class Solution:
    def diStringMatch(self, s: str) -> List[int]:
        n = len(s)
        low, high = 0, n
        res = []
        for c in s:
            if c == 'I':
                res.append(low)
                low += 1
            else:
                res.append(high)
                high -= 1
        res.append(low)
        return res