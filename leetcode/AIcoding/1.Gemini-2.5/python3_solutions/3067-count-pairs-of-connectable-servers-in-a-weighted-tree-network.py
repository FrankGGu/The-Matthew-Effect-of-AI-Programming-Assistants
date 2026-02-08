import collections
import sys

sys.setrecursionlimit(2000)

class Solution:
    def countPairsOfConnectableServers(self, edges: list[list[int]], signalSpeed: int) -> list[int]:
        n = len(edges) + 1
        graph = collections.defaultdict(list)
        for u, v, weight in edges:
            graph[u].append((v, weight))
            graph[v].append((u, weight))

        ans = [0] * n

        def dfs_count_sub_tree(u, p, current_path_dist_from_center):
            local_count = 0
            if current_path_dist_from_center % signalSpeed == 0:
                local_count += 1

            for v, w_uv in graph[u]:
                if v == p:
                    continue
                local_count += dfs_count_sub_tree(v, u, current_path_dist_from_center + w_uv)
            return local_count

        for i in range(n):
            counts_from_subtrees = []

            for neighbor, weight in graph[i]:
                count_in_this_subtree = dfs_count_sub_tree(neighbor, i, weight)
                counts_from_subtrees.append(count_in_this_subtree)

            current_pairs_for_i = 0
            prefix_sum_of_counts = 0
            for count_j in counts_from_subtrees:
                current_pairs_for_i += prefix_sum_of_counts * count_j
                prefix_sum_of_counts += count_j
            ans[i] = current_pairs_for_i

        return ans