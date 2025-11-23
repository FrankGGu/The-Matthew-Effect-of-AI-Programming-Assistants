import math

class Solution:
    def shortestToChar(self, s: str, c: str) -> list[int]:
        n = len(s)
        ans = [0] * n

        # First pass: Left to Right
        # Calculate distance to the nearest 'c' on the left (or at current position)
        prev_c_idx = -math.inf
        for i in range(n):
            if s[i] == c:
                prev_c_idx = i
            ans[i] = i - prev_c_idx

        # Second pass: Right to Left
        # Calculate distance to the nearest 'c' on the right (or at current position)
        # and take the minimum with the distance from the first pass
        next_c_idx = math.inf
        for i in range(n - 1, -1, -1):
            if s[i] == c:
                next_c_idx = i
            ans[i] = min(ans[i], next_c_idx - i)

        return ans