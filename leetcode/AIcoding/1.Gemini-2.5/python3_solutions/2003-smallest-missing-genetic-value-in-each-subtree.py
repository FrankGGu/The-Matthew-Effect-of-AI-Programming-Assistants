class Solution:
    def smallestMissingValueSubtree(self, parents: list[int], nums: list[int]) -> list[int]:
        n = len(parents)
        adj = [[] for _ in range(n)]
        for i in range(1, n):
            adj[parents[i]].append(i)

        ans = [1] * n

        # dfs returns a tuple: (set_of_values_in_subtree, smallest_missing_value_for_this_subtree)
        # The set only stores values up to N+1, as larger values don't affect the smallest missing positive integer <= N+1.
        def dfs(u, p):
            current_set = set()
            # Only consider values that could be the smallest missing (up to N+1)
            if nums[u] <= n + 1:
                current_set.add(nums[u])

            # current_ans_val tracks the smallest missing positive integer for the subtree rooted at u
            current_ans_val = 1 

            for v in adj[u]:
                if v == p:
                    continue

                child_set, child_ans_val = dfs(v, u)

                # Small-to-large merging: always merge the smaller set into the larger one
                if len(child_set) > len(current_set):
                    current_set, child_set = child_set, current_set
                    # If we swap, the current_ans_val should reflect the larger set's current missing value
                    current_ans_val = child_ans_val 

                # Merge child_set into current_set
                for val in child_set:
                    current_set.add(val)
                    # If the added value is equal to the current smallest missing,
                    # we need to find the new smallest missing by incrementing.
                    # This loop runs efficiently because current_ans_val only increases,
                    # and each increment corresponds to a distinct value being found.
                    if val == current_ans_ans_val:
                        while current_ans_val in current_set:
                            current_ans_val += 1

            # Store the computed smallest missing value for node u
            ans[u] = current_ans_val
            return current_set, current_ans_val

        # Start DFS from the root (node 0), with a dummy parent -1
        dfs(0, -1)

        return ans