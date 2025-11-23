class Solution:
    def findKthNumber(self, n: int, k: int) -> int:
        def countSteps(n, curr, next):
            steps = 0
            while curr <= n:
                steps += min(n + 1, next) - curr
                curr *= 10
                next *= 10
            return steps

        curr = 1
        k -= 1
        while k > 0:
            steps = countSteps(n, curr, curr + 1)
            if steps <= k:
                k -= steps
                curr += 1
            else:
                k -= 1
                curr *= 10
        return curr