import collections

class Solution:
    def checkWays(self, pairs: list[list[int]]) -> int:
        adj_sets = collections.defaultdict(set)
        all_nodes = set()

        for u, v in pairs:
            adj_sets[u].add(v)
            adj_sets[v].add(u)
            all_nodes.add(u)
            all_nodes.add(v)

        for node in all_nodes:
            adj_sets[node].add(node)

        num_nodes = len(all_nodes)

        root = -1
        nodes_by_size = collections.defaultdict(list) 

        for node in all_nodes:
            size = len(adj_sets[node])
            if size == num_nodes:
                root = node
            nodes_by_size[size].append(node)

        if root == -1:
            return 0

        for size in nodes_by_size:
            if len(nodes_by_size[size]) > 1:
                seen_frozensets = set()
                for node in nodes_by_size[size]:
                    f_set = frozenset(adj_sets[node])
                    if f_set in seen_frozensets:
                        return 0
                    seen_frozensets.add(f_set)

        sorted_sizes = sorted(nodes_by_size.keys())

        ways = 1

        for i in range(len(sorted_sizes)):
            current_size = sorted_sizes[i]
            for u in nodes_by_size[current_size]:
                if u == root:
                    continue

                parent_found = False
                potential_parent_adj_set = None

                for j in range(i + 1, len(sorted_sizes)):
                    next_size = sorted_sizes[j]
                    for v in nodes_by_size[next_size]:
                        if adj_sets[u].issubset(adj_sets[v]):
                            if not parent_found or len(adj_sets[v]) < len(potential_parent_adj_set):
                                potential_parent_adj_set = adj_sets[v]
                                parent_found = True

                if not parent_found:
                    return 0

                if len(potential_parent_adj_set) > len(adj_sets[u]) + 1:
                    ways = 2

        return ways