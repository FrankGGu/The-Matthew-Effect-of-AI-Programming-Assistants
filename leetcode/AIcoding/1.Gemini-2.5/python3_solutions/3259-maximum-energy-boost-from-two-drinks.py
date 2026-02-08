import collections
import bisect

class Solution:
    def maximumEnergyBoost(self, drinks: list[list[int]], k: int) -> int:
        max_overall_energy = 0

        # Case 1: Buy one drink
        # Iterate through all drinks to find the maximum energy from a single affordable drink.
        for energy, cost in drinks:
            if cost <= k:
                max_overall_energy = max(max_overall_energy, energy)

        # Case 2: Buy two drinks
        # Sort drinks by cost. This allows us to process drinks in increasing order of their cost.
        # When we process drink_i, we look for a drink_j that has a cost less than or equal to (k - cost_i).
        # By processing in sorted order, drink_j will always be a drink that appeared earlier in the list
        # or has a lower cost, implicitly handling the "distinct drinks" requirement for different costs.
        drinks.sort(key=lambda x: x[1])

        # Coordinate compression for costs
        # Create a sorted list of all unique costs to map them to 0-indexed integers.
        # This is necessary because costs can be large, but the number of unique costs (N) is not.
        all_costs = sorted(list(set(d[1] for d in drinks)))
        cost_to_idx = {cost: i for i, cost in enumerate(all_costs)}
        num_unique_costs = len(all_costs)

        # Segment Tree implementation
        # The segment tree will store the maximum energy for a given cost index range.
        # Each leaf in the segment tree corresponds to a unique compressed cost index.
        # The value at a node stores the maximum energy found among all drinks in its cost range.
        # Tree size is 4 * num_unique_costs to accommodate a binary tree with num_unique_costs leaves.
        tree = [0] * (4 * num_unique_costs)

        # Update function: updates the maximum energy for a specific cost index.
        # It ensures that tree[node] always stores the maximum energy encountered so far for its range.
        def update_tree(node, start, end, idx, val):
            if start == end: # Leaf node reached
                tree[node] = max(tree[node], val)
                return
            mid = (start + end) // 2
            if start <= idx <= mid: # idx is in the left child's range
                update_tree(2 * node, start, mid, idx, val)
            else: # idx is in the right child's range
                update_tree(2 * node + 1, mid + 1, end, idx, val)
            # Update parent node with the maximum of its children
            tree[node] = max(tree[2 * node], tree[2 * node + 1])

        # Query function: retrieves the maximum energy in a cost index range [l, r].
        def query_tree(node, start, end, l, r):
            # If the current node's range is completely outside the query range, return 0.
            if r < start or end < l:
                return 0
            # If the current node's range is completely within the query range, return its value.
            if l <= start and end <= r:
                return tree[node]
            # Otherwise, recursively query children and return the maximum.
            mid = (start + end) // 2
            p1 = query_tree(2 * node, start, mid, l, r)
            p2 = query_tree(2 * node + 1, mid + 1, end, l, r)
            return max(p1, p2)

        # Iterate through the sorted drinks. For each drink (energy_i, cost_i),
        # we treat it as one of the two drinks and try to find a complementary second drink.
        # The segment tree stores energies of drinks already processed (i.e., with lower or equal costs).
        for energy_i, cost_i in drinks:
            # Calculate the remaining budget for the second drink.
            remaining_budget = k - cost_i

            # If the remaining budget is non-negative, we can potentially find a second drink.
            if remaining_budget >= 0:
                # Find the maximum cost index in `all_costs` that is less than or equal to `remaining_budget`.
                # `bisect_right` returns an insertion point. `idx - 1` gives the index of the largest element <= value.
                query_max_cost_idx = bisect.bisect_right(all_costs, remaining_budget) - 1

                # If a valid cost index is found (meaning there are drinks within the remaining budget).
                if query_max_cost_idx >= 0:
                    # Query the segment tree for the maximum energy among all drinks
                    # whose cost index is in the range [0, query_max_cost_idx].
                    # These are drinks with cost <= remaining_budget.
                    max_energy_j = query_tree(1, 0, num_unique_costs - 1, 0, query_max_cost_idx)

                    # If a valid second drink (with energy_j > 0) was found, update the maximum overall energy.
                    # This implicitly handles the distinct drink requirement because we are querying for a drink
                    # that has been processed earlier (lower cost) or is a different instance with the same cost.
                    if max_energy_j > 0:
                        max_overall_energy = max(max_overall_energy, energy_i + max_energy_j)

            # Add the current drink's energy to the segment tree at its corresponding cost index.
            # This makes it available for subsequent drinks as a potential complementary drink.
            current_cost_idx = cost_to_idx[cost_i]
            update_tree(1, 0, num_unique_costs - 1, current_cost_idx, energy_i)

        return max_overall_energy