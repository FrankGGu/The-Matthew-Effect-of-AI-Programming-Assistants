class Solution:
    def constructArray(self, n: int, k: int) -> List[int]:
        res = []
        left, right = 1, k + 1
        while left <= right:
            res.append(left)
            left += 1
            if left <= right:
                res.append(right)
                right -= 1
        res += [i for i in range(k + 2, n + 1)]
        return res