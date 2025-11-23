class Solution:
    def canReach(self, s: str, minJump: int, maxJump: int) -> bool:
        n = len(s)
        if s[-1] == '1':
            return False

        q = [0]
        visited = {0}

        while q:
            curr = q.pop(0)

            for next_pos in range(curr + minJump, min(curr + maxJump + 1, n)):
                if s[next_pos] == '0' and next_pos not in visited:
                    if next_pos == n - 1:
                        return True
                    q.append(next_pos)
                    visited.add(next_pos)

        return False