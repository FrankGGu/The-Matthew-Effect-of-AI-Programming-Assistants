class DSU:
    def __init__(self, n):
        self.parent = list(range(n))

    def find(self, i):
        if self.parent[i] == i:
            return i
        self.parent[i] = self.find(self.parent[i])
        return self.parent[i]

    def union(self, i, j):
        root_i = self.find(i)
        root_j = self.find(j)
        if root_i != root_j:
            self.parent[root_j] = root_i
            return True
        return False

class Solution:
    def largestComponentSize(self, nums: list[int]) -> int:
        if not nums:
            return 0
        if len(nums) == 1:
            return 1

        max_val = max(nums)

        spf = list(range(max_val + 1))
        for i in range(2, int(max_val**0.5) + 1):
            if spf[i] == i:
                for j in range(i * i, max_val + 1, i):
                    if spf[j] == j:
                        spf[j] = i

        dsu = DSU(max_val + 1)

        for num in nums:
            temp_num = num
            while temp_num > 1:
                prime_factor = spf[temp_num]
                dsu.union(num, prime_factor)
                while temp_num % prime_factor == 0:
                    temp_num //= prime_factor

        component_counts = [0] * (max_val + 1)
        for num in nums:
            root = dsu.find(num)
            component_counts[root] += 1

        return max(component_counts)