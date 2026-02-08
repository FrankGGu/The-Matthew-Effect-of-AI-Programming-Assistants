from collections import deque

class Solution:
    def canReach(self, s: str, minJump: int, maxJump: int) -> bool:
        n = len(s)

        if s[n - 1] == '1':
            return False

        q = deque([0])
        last_jump_end = 0

        while q:
            curr = q.popleft()

            if curr == n - 1:
                return True

            start_scan = max(curr + minJump, last_jump_end + 1)
            end_scan = min(curr + maxJump, n - 1)

            for next_idx in range(start_scan, end_scan + 1):
                if s[next_idx] == '0':
                    if next_idx == n - 1:
                        return True
                    q.append(next_idx)

            last_jump_end = max(last_jump_end, end_scan)

        return False