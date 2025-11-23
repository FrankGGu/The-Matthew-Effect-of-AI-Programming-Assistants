class Solution:
    def findLatestGroup(self, arr: List[int], m: int) -> int:
        n = len(arr)
        parent = [i for i in range(n + 1)]
        size = [1] * (n + 1)

        def find(x):
            while parent[x] != x:
                parent[x] = parent[parent[x]]
                x = parent[x]
            return x

        def union(x, y):
            root_x = find(x)
            root_y = find(y)
            if root_x == root_y:
                return
            if size[root_x] < size[root_y]:
                root_x, root_y = root_y, root_x
            parent[root_y] = root_x
            size[root_x] += size[root_y]

        result = -1
        for i in range(n):
            current = arr[i]
            if current > 1 and find(current - 1) != find(current):
                union(current, current - 1)
            if current < n and find(current + 1) != find(current):
                union(current, current + 1)
            if size[find(current)] == m:
                result = i + 1
        return result