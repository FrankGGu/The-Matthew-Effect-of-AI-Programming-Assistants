class Solution:
    def countArrangement(self, n: int) -> int:
        self.count = 0
        visited = [False] * (n + 1)

        def backtrack(pos):
            if pos > n:
                self.count += 1
                return
            for i in range(1, n + 1):
                if not visited[i] and (i % pos == 0 or pos % i == 0):
                    visited[i] = True
                    backtrack(pos + 1)
                    visited[i] = False

        backtrack(1)
        return self.count