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
            return
        if self.rank[x_root] < self.rank[y_root]:
            self.parent[x_root] = y_root
        else:
            self.parent[y_root] = x_root
            if self.rank[x_root] == self.rank[y_root]:
                self.rank[x_root] += 1

class Solution:
    def largestComponentSize(self, nums: List[int]) -> int:
        max_num = max(nums) if nums else 0
        uf = UnionFind(max_num + 1)

        for num in nums:
            for i in range(2, int(math.sqrt(num)) + 1):
                if num % i == 0:
                    uf.union(num, i)
                    uf.union(num, num // i)

        count = defaultdict(int)
        max_size = 0
        for num in nums:
            root = uf.find(num)
            count[root] += 1
            max_size = max(max_size, count[root])

        return max_size