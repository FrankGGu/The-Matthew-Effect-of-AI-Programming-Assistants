class Solution:
    def countArrangement(self, N: int) -> int:
        def backtrack(pos, visited):
            if pos > N:
                return 1
            count = 0
            for num in range(1, N + 1):
                if not visited[num] and (num % pos == 0 or pos % num == 0):
                    visited[num] = True
                    count += backtrack(pos + 1, visited)
                    visited[num] = False
            return count

        visited = [False] * (N + 1)
        return backtrack(1, visited)