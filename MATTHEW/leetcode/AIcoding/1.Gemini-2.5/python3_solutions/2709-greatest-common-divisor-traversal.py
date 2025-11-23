class DSU:
    def __init__(self, n):
        self.parent = list(range(n))
        self.rank = [0] * n
        self.components = n

    def find(self, i):
        if self.parent[i] == i:
            return i
        self.parent[i] = self.find(self.parent[i])
        return self.parent[i]

    def union(self, i, j):
        root_i = self.find(i)
        root_j = self.find(j)
        if root_i != root_j:
            if self.rank[root_i] < self.rank[root_j]:
                self.parent[root_i] = root_j
            elif self.rank[root_i] > self.rank[root_j]:
                self.parent[root_j] = root_i
            else:
                self.parent[root_j] = root_i
                self.rank[root_i] += 1
            self.components -= 1
            return True
        return False

class Solution:
    def canTraverseAllPairs(self, nums: list[int]) -> bool:
        if len(nums) == 1:
            return True

        if 1 in nums:
            return False

        max_val = max(nums)
        dsu = DSU(len(nums))

        spf = list(range(max_val + 1))
        for i in range(2, max_val + 1):
            if spf[i] == i:
                for j in range(i * i, max_val + 1, i):
                    if spf[j] == j:
                        spf[j] = i

        prime_to_index = {}

        for i in range(len(nums)):
            num = nums[i]

            while num > 1:
                p = spf[num]
                if p in prime_to_index:
                    dsu.union(i, prime_to_index[p])
                else:
                    prime_to_index[p] = i

                while num % p == 0:
                    num //= p

        return dsu.components == 1