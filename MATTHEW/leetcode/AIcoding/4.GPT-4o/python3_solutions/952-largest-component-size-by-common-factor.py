from collections import defaultdict
import math

class Solution:
    def largestComponentSize(self, A):
        def find(x):
            if parent[x] != x:
                parent[x] = find(parent[x])
            return parent[x]

        def union(x, y):
            rootX = find(x)
            rootY = find(y)
            if rootX != rootY:
                parent[rootY] = rootX
                size[rootX] += size[rootY]

        max_val = max(A)
        parent = [i for i in range(max_val + 1)]
        size = [1] * (max_val + 1)

        for num in A:
            for factor in range(1, int(math.sqrt(num)) + 1):
                if num % factor == 0:
                    union(num, factor)
                    union(num, num // factor)

        count = defaultdict(int)
        for num in A:
            root = find(num)
            count[root] += 1

        return max(count.values())