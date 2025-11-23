import collections

class Solution:
    def sortItems(self, n: int, m: int, group: list[int], beforeItems: list[list[int]]) -> list[int]:
        # Step 1: Preprocessing groups - Assign unique group IDs to items not in any group
        # `m` is the initial number of groups. We'll use `m` as the starting ID for new groups.
        for i in range(n):
            if group[i] == -1:
                group[i] = m
                m += 1 # Increment `m` to reflect the new total number of groups

        # Step 2: Initialize graphs and data structures
        # Group-level graph
        group_adj = [[] for _ in range(m)]
        group_indegree = [0] * m

        # Item-level graphs for intra-group dependencies, stored per group
        # Using defaultdict for adjacency list and indegree to only store relevant items
        item_adj_per_group = [collections.defaultdict(list) for _ in range(m)]
        item_indegree_per_group = [collections.defaultdict(int) for _ in range(m)]

        # Map group ID to items belonging to that group (for finding nodes_to_process_subset)
        group_items = [set() for _ in range(m)] # Use set for O(1) membership check
        for i in range(n):
            group_items[group[i]].add(i)

        # Step 3: Populate graphs
        for i in range(n): # Current item is `i`
            for prev_item in beforeItems[i]: # `prev_item` must be completed before `i`
                if group[prev_item] == group[i]:
                    # Intra-group item-level dependency
                    item_adj_per_group[group[i]][prev_item].append(i)
                    item_indegree_per_group[group[i]][i] += 1
                else:
                    # Group-level dependency: group[prev_item] -> group[i]
                    group_adj[group[prev_item]].append(group[i])
                    group_indegree[group[i]] += 1

        # Step 4: Topological Sort Helper Function for dictionary-based graphs (for items)
        def topological_sort_dict(adj_map, indegree_map, nodes_to_process_subset):
            q = collections.deque()
            sorted_nodes = []

            for node in nodes_to_process_subset:
                if indegree_map[node] == 0: # defaultdict handles non-existent keys as 0
                    q.append(node)

            while q:
                u = q.popleft()
                sorted_nodes.append(u)

                for v in adj_map[u]: # defaultdict handles non-existent keys as empty list
                    indegree_map[v] -= 1
                    if indegree_map[v] == 0:
                        q.append(v)

            if len(sorted_nodes) == len(nodes_to_process_subset):
                return sorted_nodes
            else:
                return []

        # Step 4: Topological Sort Helper Function for list-based graphs (for groups)
        def topological_sort_list(adj_list, indegree_list, num_nodes):
            q = collections.deque()
            sorted_list = []

            for i in range(num_nodes):
                if indegree_list[i] == 0:
                    q.append(i)

            while q:
                u = q.popleft()
                sorted_list.append(u)

                for v in adj_list[u]:
                    indegree_list[v] -= 1
                    if indegree_list[v] == 0:
                        q.append(v)

            if len(sorted_list) == num_nodes:
                return sorted_list
            else:
                return []

        # Step 5: Sort Groups
        # Pass a copy of group_indegree because topological_sort_list modifies it.
        sorted_groups = topological_sort_list(group_adj, group_indegree[:], m)
        if not sorted_groups:
            return []

        # Step 6: Sort Items within each Group
        sorted_items_in_group = [[] for _ in range(m)]

        for g in range(m):
            # `item_adj_per_group[g]` and `item_indegree_per_group[g]` are already specific to group `g`.
            # They are defaultdicts, so we pass them directly.
            # `nodes_to_process_subset` is `group_items[g]` (a set).
            items_of_g_sorted = topological_sort_dict(item_adj_per_group[g], item_indegree_per_group[g], group_items[g])
            if not items_of_g_sorted:
                return []
            sorted_items_in_group[g] = items_of_g_sorted

        # Step 7: Combine Results
        result = []
        for g in sorted_groups:
            result.extend(sorted_items_in_group[g])

        return result