class Solution:
    def gcd(self, a, b):
        while b:
            a, b = b, a % b
        return a

    def gcdSort(self, nums: List[int]) -> bool:
        n = len(nums)
        sorted_nums = sorted(nums)
        parent = list(range(max(nums) + 1))

        def find(i):
            if parent[i] == i:
                return i
            parent[i] = find(parent[i])
            return parent[i]

        def union(i, j):
            root_i = find(i)
            root_j = find(j)
            if root_i != root_j:
                parent[root_i] = root_j

        for i in range(2, max(nums) + 1):
            for j in range(i, max(nums) + 1, i):
                if j in set(nums):
                    union(i, j)

        for i in range(n):
            if find(nums[i]) != find(sorted_nums[i]):
                return False
        return True