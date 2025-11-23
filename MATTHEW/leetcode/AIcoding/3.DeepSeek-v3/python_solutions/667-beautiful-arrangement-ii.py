class Solution:
    def constructArray(self, n: int, k: int) -> List[int]:
        res = []
        left, right = 1, n
        for i in range(n):
            if k > 1:
                if i % 2 == 0:
                    res.append(left)
                    left += 1
                else:
                    res.append(right)
                    right -= 1
                k -= 1
            else:
                if i % 2 == 0:
                    res.append(left)
                    left += 1
                else:
                    res.append(right)
                    right -= 1
        return res