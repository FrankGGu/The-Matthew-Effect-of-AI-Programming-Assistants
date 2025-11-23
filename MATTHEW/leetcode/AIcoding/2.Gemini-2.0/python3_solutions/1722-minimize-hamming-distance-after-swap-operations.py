class Solution:
    def minHammingDistance(self, source: List[int], target: List[int], allowedSwaps: List[List[int]]) -> int:
        n = len(source)
        parent = list(range(n))

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

        for i, j in allowedSwaps:
            union(i, j)

        groups = defaultdict(list)
        for i in range(n):
            groups[find(i)].append(i)

        ans = 0
        for group in groups.values():
            source_counts = defaultdict(int)
            target_counts = defaultdict(int)
            for idx in group:
                source_counts[source[idx]] += 1
                target_counts[target[idx]] += 1

            for num, count in source_counts.items():
                if num in target_counts:
                    common = min(count, target_counts[num])
                    source_counts[num] -= common
                    target_counts[num] -= common

            for num, count in source_counts.items():
                ans += count

        return ans