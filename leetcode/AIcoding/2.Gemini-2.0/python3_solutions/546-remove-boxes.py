class Solution:
    def removeBoxes(self, boxes: List[int]) -> int:
        n = len(boxes)
        dp = {}

        def solve(l, r, k):
            if l > r:
                return 0
            if (l, r, k) in dp:
                return dp[(l, r, k)]

            while l < r and boxes[l] == boxes[l + 1]:
                l += 1
                k += 1

            res = (k + 1) * (k + 1) + solve(l + 1, r, 0)

            for i in range(l + 1, r + 1):
                if boxes[i] == boxes[l]:
                    res = max(res, solve(l + 1, i - 1, 0) + solve(i, r, k + 1))

            dp[(l, r, k)] = res
            return res

        return solve(0, n - 1, 0)