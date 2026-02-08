import collections

class Line:
    def __init__(self, m, c):
        self.m = m
        self.c = c

    def eval(self, x):
        return self.m * x + self.c

class LiChaoTree:
    def __init__(self, min_x, max_x):
        self.min_x = min_x
        self.max_x = max_x
        # nodes list to store lines in the segment tree. Max 4N nodes.
        self.nodes = [None] * (4 * (max_x - min_x + 1)) 
        # Using a large negative number for queries where no line is present
        self.INF = -float('inf') 

    # Adds a line to the Li Chao Tree
    def add_line(self, new_line):
        self._add_line_recursive(new_line, 0, self.min_x, self.max_x)

    # Recursive helper for adding a line
    def _add_line_recursive(self, new_line, node_idx, current_min_x, current_max_x):
        mid_x = (current_min_x + current_max_x) // 2

        # If no line exists at this node, just place the new line here
        if self.nodes[node_idx] is None:
            self.nodes[node_idx] = new_line
            return

        line_at_node = self.nodes[node_idx]

        # Check which line is better at the mid-point of the current range
        is_new_better_mid = new_line.eval(mid_x) > line_at_node.eval(mid_x)

        # If the new line is better at mid_x, swap them.
        # The line_at_node will now be the one that is worse at mid_x.
        if is_new_better_mid:
            self.nodes[node_idx] = new_line
            new_line = line_at_node # The old line_at_node is now the one to be pushed down

        # If it's a leaf node, we are done after placing the better line
        if current_min_x == current_max_x:
            return

        # Determine if the new_line (which is worse at mid_x) intersects with the line_at_node (which is better at mid_x)
        # in the left half or right half.
        # If new_line is better at current_min_x, it means they intersect in the left half.
        # Push new_line (which is worse at mid_x but better at current_min_x) to the left child.
        if new_line.eval(current_min_x) > self.nodes[node_idx].eval(current_min_x):
            self._add_line_recursive(new_line, 2 * node_idx + 1, current_min_x, mid_x)
        else: # Otherwise, they intersect in the right half (or new_line is worse everywhere in the left half).
              # Push new_line (which is worse at mid_x) to the right child.
            self._add_line_recursive(new_line, 2 * node_idx + 2, mid_x + 1, current_max_x)

    # Queries the Li Chao Tree for the maximum value at a given x-coordinate
    def query(self, x):
        return self._query_recursive(x, 0, self.min_x, self.max_x)

    # Recursive helper for querying
    def _query_recursive(self, x, node_idx, current_min_x, current_max_x):
        # If no line at this node, return -infinity
        if self.nodes[node_idx] is None:
            return self.INF

        # Current best value from the line stored at this node
        res = self.nodes[node_idx].eval(x)

        # If it's a leaf node, we are done
        if current_min_x == current_max_x:
            return res

        # Recurse into the appropriate child based on x
        mid_x = (current_min_x + current_max_x) // 2
        if x <= mid_x:
            res = max(res, self._query_recursive(x, 2 * node_idx + 1, current_min_x, mid_x))
        else:
            res = max(res, self._query_recursive(x, 2 * node_idx + 2, mid_x + 1, current_max_x))
        return res

class Solution:
    def maximumStrength(self, nums: list[int], k: int) -> int:
        n = len(nums)

        # prefix_sum[i] = sum(nums[0...i-1])
        prefix_sum = [0] * (n + 1)
        for i in range(n):
            prefix_sum[i+1] = prefix_sum[i] + nums[i]

        # prefix_weighted_sum[i] = sum_{j=0}^{i-1} (nums[j] * j)
        prefix_weighted_sum = [0] * (n + 1)
        for i in range(n):
            prefix_weighted_sum[i+1] = prefix_weighted_sum[i] + nums[i] * i

        # dp_overall[j][i] stores the maximum strength using 'j' subarrays,
        # considering elements up to index 'i-1' (i.e., nums[0...i-1]).
        # dp_overall[j][0] means 0 elements, so 0 strength.

        # We use space optimization: prev_dp_overall for dp_overall[j-1] and curr_dp_overall for dp_overall[j].

        INF = -float('inf') # Using a large negative number for -infinity

        # Initialize prev_dp_overall for j=0 subarrays. Max strength is 0.
        prev_dp_overall = [0] * (n + 1) 

        # Determine the parity factor for the strength calculation.
        # The problem states "if k is odd" / "if k is even", implying the factor is constant for all subarrays.
        parity_factor = 1 if k % 2 == 1 else -1

        # Iterate for each number of subarrays 'j' from 1 to k
        for j in range(1, k + 1):
            curr_dp_overall = [INF] * (n + 1) # Initialize current DP array for 'j' subarrays

            # Li Chao Tree to optimize the maximization step.
            # We want to maximize C_p - M_p * X, where X = i+1.
            # The x-coordinates (i+1) range from 1 to n.
            # So, the Li Chao Tree should cover this range.
            lct = LiChaoTree(0, n) 

            # Add the base case line for p=0 (subarray starts at index 0).
            # C_p = prev_dp_overall[p] + parity_factor * prefix_weighted_sum[p]
            # M_p = parity_factor * prefix_sum[p]
            # For p=0:
            #   C_0 = prev_dp_overall[0] + parity_factor * prefix_weighted_sum[0] = 0 + 0 = 0
            #   M_0 = parity_factor * prefix_sum[0] = 0
            # So, the line is y = 0 * X + 0, i.e., y = 0.
            # We add this line to the LCT.
            lct.add_line(Line(0, 0))

            # Iterate through each possible ending index 'i' for the j-th subarray
            for i in range(n): 
                # Calculate the constant part of the strength formula for the current 'i'.
                # This part is: parity_factor * (prefix_sum[i+1] * (i+1) - prefix_weighted_sum[i+1])
                constant_part = parity_factor * (prefix_sum[i+1] * (i+1) - prefix_weighted_sum[i+1])

                # Query the Li Chao Tree for the maximum value at X = i+1.
                # The LCT stores lines of the form `y = (-M_p) * X + C_p`.
                # This query finds `max_{0 <= p <= i} (prev_dp_overall[p] + P * P_W[p] - P * P_S[p] * (i+1))`.
                max_from_lct = lct.query(i+1)

                # If max_from_lct is -INF, it means no valid previous subarrays could be formed,
                # so current_dp_ending_at_i should also be -INF.
                current_dp_ending_at_i = INF
                if max_from_lct != INF:
                    current_dp_ending_at_i = constant_part + max_from_lct

                # Update curr_dp_overall[i+1] (max strength using 'j' subarrays considering nums[0...i]).
                # This can either be the strength from not using nums[i] (curr_dp_overall[i])
                # or the strength from using nums[i] as the end of the j-th subarray (current_dp_ending_at_i).
                curr_dp_overall[i+1] = max(curr_dp_overall[i], current_dp_ending_at_i)

                # Add a new line to the Li Chao Tree for the next iteration (p = i+1).
                # This line represents the possibility of starting a new j-th subarray at index i+1.
                # Only add if prev_dp_overall[i+1] is a valid strength (not -INF).
                if prev_dp_overall[i+1] != INF:
                    m_val = -parity_factor * prefix_sum[i+1]
                    c_val = prev_dp_overall[i+1] + parity_factor * prefix_weighted_sum[i+1]
                    lct.add_line(Line(m_val, c_val))

            # After processing all 'i' for current 'j', update prev_dp_overall for the next iteration of 'j'.
            prev_dp_overall = curr_dp_overall

        # The final answer is the maximum strength using 'k' subarrays considering all 'n' elements.
        return prev_dp_overall[n]