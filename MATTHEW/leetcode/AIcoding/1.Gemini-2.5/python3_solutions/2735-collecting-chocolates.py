class Solution:
    def collectChocolates(self, types: list[int], cost: list[int], x: int) -> int:
        n = len(types)

        # min_cost_for_each_pos[i] will store the minimum cost to collect
        # the chocolate at index i, considering all possible type shifts.
        # Initially, for k=0 (no shifts), the cost for chocolate i is cost[types[i]].
        min_cost_for_each_pos = [0] * n
        for i in range(n):
            min_cost_for_each_pos[i] = cost[types[i]]

        # Iterate through possible number of shifts (k_shifts) from 1 to n-1.
        # k_shifts represents how many positions a type has been propagated clockwise
        # to reach its current position. Each such propagation costs 'x'.
        for k_shifts in range(1, n):
            # For each position i, we consider if it's cheaper to get its type
            # from `k_shifts` positions back (circularly).
            for i in range(n):
                # Calculate the original index from which the type is propagated to `i`.
                # If `k_shifts` is 1, type at `i` could come from `(i-1+n)%n`.
                # If `k_shifts` is 2, type at `i` could come from `(i-2+n)%n`, and so on.
                original_type_source_idx = (i - k_shifts + n) % n

                # Calculate the cost if chocolate at `i` gets `types[original_type_source_idx]`.
                # This cost is `cost[types[original_type_source_idx]]` plus the `k_shifts * x`
                # cost for propagating the type.
                candidate_cost = cost[types[original_type_source_idx]] + k_shifts * x

                # Update the minimum cost for position `i` if this candidate is cheaper.
                min_cost_for_each_pos[i] = min(min_cost_for_each_pos[i], candidate_cost)

        # The total minimum cost is the sum of the minimum costs for each position.
        return sum(min_cost_for_each_pos)