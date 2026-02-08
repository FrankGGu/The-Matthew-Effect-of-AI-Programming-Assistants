class UnionFind:
    def __init__(self, size):
        self.parent = list(range(size))
        self.rank = [0] * size

    def find(self, x):
        if self.parent[x] != x:
            self.parent[x] = self.find(self.parent[x])
        return self.parent[x]

    def union(self, x, y):
        x_root = self.find(x)
        y_root = self.find(y)
        if x_root == y_root:
            return False
        if self.rank[x_root] < self.rank[y_root]:
            self.parent[x_root] = y_root
        else:
            self.parent[y_root] = x_root
            if self.rank[x_root] == self.rank[y_root]:
                self.rank[x_root] += 1
        return True

class Solution:
    def friendRequests(self, n: int, restrictions: List[List[int]], requests: List[List[int]]) -> List[bool]:
        uf = UnionFind(n)
        res = []
        for u, v in requests:
            u_root = uf.find(u)
            v_root = uf.find(v)
            valid = True
            for a, b in restrictions:
                a_root = uf.find(a)
                b_root = uf.find(b)
                if (a_root == u_root and b_root == v_root) or (a_root == v_root and b_root == u_root):
                    valid = False
                    break
            if valid:
                uf.union(u, v)
                res.append(True)
            else:
                res.append(False)
        return res