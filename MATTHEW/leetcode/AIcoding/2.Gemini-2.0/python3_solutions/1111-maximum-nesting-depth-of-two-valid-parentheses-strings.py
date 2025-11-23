class Solution:
    def maxDepthAfterSplit(self, seq: str) -> List[int]:
        ans = []
        a = 0
        b = 0
        for c in seq:
            if c == '(':
                if a < b:
                    ans.append(0)
                    a += 1
                else:
                    ans.append(1)
                    b += 1
            else:
                if a > b:
                    ans.append(0)
                    a -= 1
                else:
                    ans.append(1)
                    b -= 1
        return ans