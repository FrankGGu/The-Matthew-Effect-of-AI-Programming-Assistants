from typing import List
import heapq

class Solution:
    def findCriticalAndPseudoCriticalEdges(self, n: int, edges: List[List[int]]) -> List[List[int]]:
        def kruskal(edges, include=None, exclude=None):
            parent = list(range(n))
            def find(x):
                while parent[x] != x:
                    parent[x] = parent[parent[x]]
                    x = parent[x]
                return x
            def union(x, y):
                fx = find(x)
                fy = find(y)
                if fx == fy:
                    return False
                parent[fy] = fx
                return True
            edges = sorted(edges, key=lambda x: x[2])
            res = 0
            count = 0
            for i, (u, v, w) in enumerate(edges):
                if include is not None and i == include:
                    if union(u, v):
                        res += w
                        count += 1
                elif exclude is not None and i == exclude:
                    continue
                else:
                    if union(u, v):
                        res += w
                        count += 1
            return res if count == n - 1 else float('inf')

        edges = [(i, u, v, w) for i, (u, v, w) in enumerate(edges)]
        min_weight = kruskal(edges)
        critical = []
        pseudo_critical = []
        for i, u, v, w in edges:
            weight = kruskal(edges, exclude=i)
            if weight > min_weight:
                critical.append(i)
            else:
                weight = kruskal(edges, include=i)
                if weight == min_weight:
                    pseudo_critical.append(i)
        return [critical, pseudo_critical]