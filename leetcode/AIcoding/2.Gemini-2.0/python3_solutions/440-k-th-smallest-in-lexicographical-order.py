class Solution:
    def findKthNumber(self, n: int, k: int) -> int:
        def get_steps(curr, n):
            steps = 0
            first = curr
            last = curr + 1
            while first <= n:
                steps += min(n + 1, last) - first
                first *= 10
                last *= 10
            return steps

        curr = 1
        k -= 1
        while k > 0:
            steps = get_steps(curr, n)
            if steps <= k:
                curr += 1
                k -= steps
            else:
                curr *= 10
                k -= 1
        return curr