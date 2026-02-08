import collections

class Solution:
    def minJumps(self, arr: list[int]) -> int:
        n = len(arr)
        if n <= 1:
            return 0

        # Create a map from value to a list of indices where it appears
        val_to_indices = collections.defaultdict(list)
        for i in range(n):
            val_to_indices[arr[i]].append(i)

        # BFS queue stores (index, steps)
        queue = collections.deque([(0, 0)])

        # Set to keep track of visited indices
        visited = {0}

        while queue:
            curr_idx, steps = queue.popleft()

            # If we reached the last index, return the steps
            if curr_idx == n - 1:
                return steps

            # Explore possible jumps:

            # 1. Jump to curr_idx + 1
            if curr_idx + 1 < n and curr_idx + 1 not in visited:
                visited.add(curr_idx + 1)
                queue.append((curr_idx + 1, steps + 1))

            # 2. Jump to curr_idx - 1
            if curr_idx - 1 >= 0 and curr_idx - 1 not in visited:
                visited.add(curr_idx - 1)
                queue.append((curr_idx - 1, steps + 1))

            # 3. Jump to any index j where arr[j] == arr[curr_idx]
            current_val = arr[curr_idx]
            if current_val in val_to_indices: # Check if this value's indices haven't been processed yet
                for next_idx in val_to_indices[current_val]:
                    if next_idx not in visited:
                        visited.add(next_idx)
                        queue.append((next_idx, steps + 1))
                # Crucial optimization: Clear the list for this value after processing.
                # This prevents re-processing the same set of indices for a value
                # multiple times, which would lead to TLE for cases like [7,7,7...,7,11].
                del val_to_indices[current_val]

        # This line should ideally not be reached as a path is guaranteed
        return -1