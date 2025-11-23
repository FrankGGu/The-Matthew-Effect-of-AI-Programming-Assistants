import collections
from itertools import combinations

class Solution:
    def numberOfCoins(self, n: int, edges: list[list[int]], values: list[int]) -> list[int]:
        adj = collections.defaultdict(list)
        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)

        ans = [0] * n

        def dfs(u, parent):
            # current_subtree_values will accumulate relevant values from u and its children.
            # It will always be kept trimmed to at most 5 unique elements (2 smallest, 3 largest).
            current_subtree_values = [values[u]]
            node_count = 1

            for v in adj[u]:
                if v == parent:
                    continue

                child_count, child_relevant_vals = dfs(v, u)
                node_count += child_count

                # Combine current_subtree_values (from u and already processed children)
                # with child_relevant_vals (from the current child v).
                # Both are sorted lists of at most 5 unique elements.

                temp_combined_list = []
                temp_combined_list.extend(current_subtree_values)
                temp_combined_list.extend(child_relevant_vals)
                temp_combined_list.sort() # Sort the combined list (max 10 elements)

                # Now trim temp_combined_list to at most 5 unique values (2 smallest, 3 largest)
                trimmed_list = []
                if len(temp_combined_list) >= 1: trimmed_list.append(temp_combined_list[0])
                if len(temp_combined_list) >= 2: trimmed_list.append(temp_combined_list[1])

                # Add largest 3 if they exist
                if len(temp_combined_list) >= 3: trimmed_list.append(temp_combined_list[-3])
                if len(temp_combined_list) >= 4: trimmed_list.append(temp_combined_list[-2])
                if len(temp_combined_list) >= 5: trimmed_list.append(temp_combined_list[-1])

                # Ensure uniqueness and sorted order for the next iteration
                current_subtree_values = sorted(list(set(trimmed_list)))

            if node_count < 3:
                ans[u] = 1
            else:
                # If node_count >= 3, then current_subtree_values must have at least 3 elements.
                # (Because it contains the 3 largest values from a list of at least 3 values).
                current_products = []
                for c in combinations(current_subtree_values, 3):
                    current_products.append(c[0] * c[1] * c[2])

                ans[u] = max(0, max(current_products))

            return node_count, current_subtree_values

        dfs(0, -1) 
        return ans