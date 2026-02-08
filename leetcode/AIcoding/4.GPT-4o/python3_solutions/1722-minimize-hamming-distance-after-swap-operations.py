class Solution:
    def minimumHammingDistance(self, source: List[int], target: List[int], allowedSwaps: List[List[int]]) -> int:
        parent = list(range(len(source)))

        def find(x):
            if parent[x] != x:
                parent[x] = find(parent[x])
            return parent[x]

        def union(x, y):
            rootX = find(x)
            rootY = find(y)
            if rootX != rootY:
                parent[rootY] = rootX

        for x, y in allowedSwaps:
            union(x, y)

        groups = defaultdict(list)
        for i in range(len(source)):
            root = find(i)
            groups[root].append(i)

        hamming_distance = 0
        for indices in groups.values():
            source_count = defaultdict(int)
            target_count = defaultdict(int)
            for index in indices:
                source_count[source[index]] += 1
                target_count[target[index]] += 1
            hamming_distance += sum((source_count[num] - min(source_count[num], target_count[num])) for num in source_count)

        return hamming_distance