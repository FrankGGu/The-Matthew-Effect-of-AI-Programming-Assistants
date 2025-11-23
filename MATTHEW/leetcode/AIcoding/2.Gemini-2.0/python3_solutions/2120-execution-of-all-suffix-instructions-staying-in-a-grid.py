class Solution:
    def executeInstructions(self, n: int, startPos: List[int], s: str) -> List[int]:
        ans = []
        for i in range(len(s)):
            x, y = startPos[0], startPos[1]
            count = 0
            for j in range(i, len(s)):
                if s[j] == 'R':
                    y += 1
                elif s[j] == 'L':
                    y -= 1
                elif s[j] == 'U':
                    x -= 1
                else:
                    x += 1
                if not (0 <= x < n and 0 <= y < n):
                    break
                count += 1
            ans.append(count)
        return ans