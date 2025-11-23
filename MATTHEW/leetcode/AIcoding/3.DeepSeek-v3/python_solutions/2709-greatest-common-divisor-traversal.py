import math
from collections import defaultdict

class Solution:
    def canTraverseAllPairs(self, nums: List[int]) -> bool:
        if len(nums) == 1:
            return True

        parent = {}
        size = defaultdict(int)

        def find(u):
            while parent[u] != u:
                parent[u] = parent[parent[u]]
                u = parent[u]
            return u

        def union(u, v):
            u_root = find(u)
            v_root = find(v)
            if u_root == v_root:
                return
            if size[u_root] < size[v_root]:
                parent[u_root] = v_root
                size[v_root] += size[u_root]
            else:
                parent[v_root] = u_root
                size[u_root] += size[v_root]

        prime_to_index = {}

        for i, num in enumerate(nums):
            if num == 1:
                return False
            factors = self.get_prime_factors(num)
            for p in factors:
                if p in prime_to_index:
                    union(i, prime_to_index[p])
                else:
                    prime_to_index[p] = i

        root = find(0)
        for i in range(len(nums)):
            if find(i) != root:
                return False
        return True

    def get_prime_factors(self, n):
        factors = set()
        while n % 2 == 0:
            factors.add(2)
            n = n // 2
        i = 3
        while i * i <= n:
            while n % i == 0:
                factors.add(i)
                n = n // i
            i += 2
        if n > 2:
            factors.add(n)
        return factors