from collections import defaultdict, Counter

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
            self.parent[root_i] = root_j
            return True
        return False

class Solution:
    def minimizeHammingDistance(self, source: list[int], target: list[int], allowedSwaps: list[list[int]]) -> int:
        n = len(source)
        dsu = DSU(n)

        for u, v in allowedSwaps:
            dsu.union(u, v)

        groups = defaultdict(list)
        for i in range(n):
            groups[dsu.find(i)].append(i)

        min_hamming_distance = 0

        for indices_in_component in groups.values():
            source_counts = Counter()
            target_counts = Counter()

            for idx in indices_in_component:
                source_counts[source[idx]] += 1
                target_counts[target[idx]] += 1

            matched_elements_in_component = 0
            for val in source_counts:
                matched_elements_in_component += min(source_counts[val], target_counts[val])

            min_hamming_distance += len(indices_in_component) - matched_elements_in_component

        return min_hamming_distance