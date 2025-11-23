class Solution:
    def maximizeFunctionValue(self, receiver: list[int], k: int) -> int:
        n = len(receiver)

        # MAX_J is chosen such that 2^(MAX_J-1) is greater than or equal to k.
        # k can be up to 10^10. log2(10^10) is approximately 33.2.
        # So, we need powers of 2 up to 2^33 or 2^34.
        # Using MAX_J = 35 ensures we cover all bits for k up to 10^10.
        # j will range from 0 to 34.
        MAX_J = 35 

        # next_node[j][i] stores the node reached from i after 2^j passes.
        next_node = [[0] * n for _ in range(MAX_J)]
        # sum_val[j][i] stores the sum of values of the first 2^j nodes
        # in the path starting from i. This includes the starting node i
        # and excludes the node reached AFTER 2^j steps.
        # For example, sum_val[0][i] = i (sum of 1 node).
        # sum_val[1][i] = i + receiver[i] (sum of 2 nodes).
        sum_val = [[0] * n for _ in range(MAX_J)]

        # Base case: j = 0 (representing 2^0 = 1 pass/step)
        for i in range(n):
            next_node[0][i] = receiver[i]
            sum_val[0][i] = i

        # Precompute for j from 1 up to MAX_J - 1
        for j in range(1, MAX_J):
            for i in range(n):
                # To find the node after 2^j passes from i:
                # First, go 2^(j-1) passes from i to an intermediate_node.
                intermediate_node = next_node[j-1][i]
                # Then, go another 2^(j-1) passes from the intermediate_node.
                next_node[j][i] = next_node[j-1][intermediate_node]

                # To find the sum of 2^j node values in the path starting from i:
                # This is the sum of the first 2^(j-1) nodes from i,
                # plus the sum of the first 2^(j-1) nodes from the intermediate_node.
                sum_val[j][i] = sum_val[j-1][i] + sum_val[j-1][intermediate_node]

        max_overall_value = 0

        # For each possible starting node 's' (from 0 to n-1)
        for s in range(n):
            current_sum_for_s = 0
            current_node = s

            # The problem asks for the sum of k+1 terms (initial node + k subsequent nodes).
            # So we need to sum 'k + 1' values.
            remaining_terms_count = k + 1

            # Use binary lifting to sum the values for 'remaining_terms_count' terms.
            # Iterate from the largest power of 2 down to 0.
            for j in range(MAX_J - 1, -1, -1):
                # If the j-th bit of remaining_terms_count is set,
                # it means we need to include a block of 2^j terms.
                if (remaining_terms_count >> j) & 1:
                    # Add the precomputed sum of 2^j terms starting from current_node.
                    current_sum_for_s += sum_val[j][current_node]
                    # Advance current_node by 2^j passes.
                    current_node = next_node[j][current_node]

            # Update the maximum value found so far.
            max_overall_value = max(max_overall_value, current_sum_for_s)

        return max_overall_value