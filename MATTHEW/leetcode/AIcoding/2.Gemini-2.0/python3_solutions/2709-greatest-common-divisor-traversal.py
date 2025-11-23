def gcd(a, b):
    if b == 0:
        return a
    return gcd(b, a % b)

def find_factors(num):
    factors = set()
    d = 2
    while d * d <= num:
        if num % d == 0:
            factors.add(d)
            while num % d == 0:
                num //= d
        d += 1
    if num > 1:
        factors.add(num)
    return factors

class Solution:
    def canTraverseAllPairs(self, nums: list[int]) -> bool:
        n = len(nums)
        if n == 1:
            return True

        parent = list(range(n))
        size = [1] * n

        def find(i):
            if parent[i] == i:
                return i
            parent[i] = find(parent[i])
            return parent[i]

        def union(i, j):
            root_i = find(i)
            root_j = find(j)
            if root_i != root_j:
                if size[root_i] < size[root_j]:
                    parent[root_i] = root_j
                    size[root_j] += size[root_i]
                else:
                    parent[root_j] = root_i
                    size[root_i] += size[root_j]

        factor_to_node = {}

        for i, num in enumerate(nums):
            factors = find_factors(num)
            for factor in factors:
                if factor in factor_to_node:
                    union(i, factor_to_node[factor])
                else:
                    factor_to_node[factor] = i

        return all(find(i) == find(0) for i in range(n))