class Solution:
    def calculateScore(self, s: str, k: int) -> int:
        n = len(s)
        score = 0
        left = 0
        right = n - 1
        directions = {'L': -1, 'R': 1}
        visited = [False] * n

        while left <= right:
            if directions[s[left]] == -1 and not visited[left]:
                score += 1
                visited[left] = True
                right -= k
            elif directions[s[right]] == 1 and not visited[right]:
                score += 1
                visited[right] = True
                left += k
            else:
                if not visited[left]:
                    left += 1
                if not visited[right]:
                    right -= 1
                if visited[left] and visited[right]:
                    break

        return score