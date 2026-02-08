class TreeNode:
    def __init__(self, x):
        self.val = x
        self.left = None
        self.right = None

class TreeAncestor:

    def __init__(self, n: int, parent: List[int]):
        self.ancestor = [[-1] * 20 for _ in range(n)]
        for child in range(n):
            self.ancestor[child][0] = parent[child]
        for j in range(1, 20):
            for i in range(n):
                if self.ancestor[i][j - 1] != -1:
                    self.ancestor[i][j] = self.ancestor[self.ancestor[i][j - 1]][j - 1]

    def getKthAncestor(self, node: int, k: int) -> int:
        for j in range(20):
            if k & (1 << j):
                node = self.ancestor[node][j]
                if node == -1:
                    return -1
        return node