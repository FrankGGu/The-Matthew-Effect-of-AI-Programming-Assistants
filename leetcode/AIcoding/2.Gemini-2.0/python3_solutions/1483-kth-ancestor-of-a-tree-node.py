class TreeAncestor:

    def __init__(self, n: int, parent: list[int]):
        self.n = n
        self.max_level = 0
        while (1 << self.max_level) <= n:
            self.max_level += 1

        self.dp = [[-1] * n for _ in range(self.max_level)]

        for i in range(n):
            self.dp[0][i] = parent[i]

        for i in range(1, self.max_level):
            for j in range(n):
                if self.dp[i-1][j] != -1:
                    self.dp[i][j] = self.dp[i-1][self.dp[i-1][j]]

    def getKthAncestor(self, node: int, k: int) -> int:
        for i in range(self.max_level):
            if (k >> i) & 1:
                node = self.dp[i][node]
                if node == -1:
                    return -1
        return node