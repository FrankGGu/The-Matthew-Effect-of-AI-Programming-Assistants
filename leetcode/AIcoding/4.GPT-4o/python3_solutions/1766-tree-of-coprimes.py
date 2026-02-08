from collections import defaultdict
from math import gcd
from sys import setrecursionlimit

class Solution:
    def getCoprimes(self, edges: List[List[int]], nums: List[int]) -> List[int]:
        setrecursionlimit(10**6)
        graph = defaultdict(list)
        n = len(nums)

        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        result = [-1] * n
        coprime_nodes = defaultdict(list)

        def dfs(node, parent, depth):
            max_coprime_depth = -1
            coprime_node = -1

            for neighbor in graph[node]:
                if neighbor == parent:
                    continue
                d, c = dfs(neighbor, node, depth + 1)
                if d > max_coprime_depth:
                    max_coprime_depth = d
                    coprime_node = c

            if depth > 0:
                for k in list(coprime_nodes.keys()):
                    if gcd(nums[node], k) == 1:
                        if depth > coprime_nodes[k][0]:
                            coprime_nodes[k] = (depth, node)

            coprime_nodes[nums[node]].append((depth, node))
            if coprime_node != -1:
                result[node] = coprime_node

            return max(max_coprime_depth, depth), coprime_node

        dfs(0, -1, 0)
        return result