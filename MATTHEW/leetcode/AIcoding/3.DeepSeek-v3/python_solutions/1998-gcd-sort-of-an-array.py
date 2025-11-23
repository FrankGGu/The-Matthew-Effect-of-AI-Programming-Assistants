class UnionFind:
    def __init__(self, size):
        self.parent = list(range(size))

    def find(self, x):
        while self.parent[x] != x:
            self.parent[x] = self.parent[self.parent[x]]
            x = self.parent[x]
        return x

    def union(self, x, y):
        fx = self.find(x)
        fy = self.find(y)
        if fx != fy:
            self.parent[fy] = fx

class Solution:
    def gcdSort(self, nums: List[int]) -> bool:
        max_num = max(nums)
        spf = list(range(max_num + 1))
        for i in range(2, int(max_num ** 0.5) + 1):
            if spf[i] == i:
                for j in range(i * i, max_num + 1, i):
                    if spf[j] == j:
                        spf[j] = i

        uf = UnionFind(max_num + 1)
        for num in nums:
            x = num
            while x > 1:
                p = spf[x]
                uf.union(p, num)
                while x % p == 0:
                    x = x // p

        sorted_nums = sorted(nums)
        for a, b in zip(nums, sorted_nums):
            if uf.find(a) != uf.find(b):
                return False
        return True