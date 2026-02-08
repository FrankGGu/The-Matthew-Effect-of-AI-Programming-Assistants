class TreeAncestor:

    def __init__(self, n: int, parent: List[int]):
        self.log = 0
        while (1 << self.log) <= n:
            self.log += 1
        self.up = [[-1] * n for _ in range(self.log)]
        for v in range(n):
            self.up[0][v] = parent[v]
        for k in range(1, self.log):
            for v in range(n):
                if self.up[k - 1][v] != -1:
                    self.up[k][v] = self.up[k - 1][self.up[k - 1][v]]

    def getKthAncestor(self, node: int, k: int) -> int:
        for i in range(self.log):
            if k & (1 << i):
                node = self.up[i][node]
                if node == -1:
                    break
        return node