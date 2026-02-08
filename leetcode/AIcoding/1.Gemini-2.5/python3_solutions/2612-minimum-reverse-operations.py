import collections

class Solution:
    def minReverseOperations(self, n: int, p: int, banned: list[int], k: int) -> list[int]:
        # DSU structure to efficiently find the next available unvisited node.
        # `next_available[i]` stores the smallest index `j >= i` that is currently unvisited.
        # When a node `i` is visited, we update `next_available[i]` to `i + 1`.
        # Path compression in `find_next_available` makes operations nearly O(1) amortized.
        next_available = list(range(n + 2)) # `n+2` size to handle indices up to `n+1` as sentinel.

        def find_next_available(i):
            if next_available[i] == i:
                return i
            next_available[i] = find_next_available(next_available[i])
            return next_available[i]

        ans = [-1] * n
        banned_set = set(banned)

        # Mark banned nodes as unavailable in the DSU structure.
        # By setting `next_available[b_idx] = b_idx + 1`, any `find_next_available(b_idx)`
        # will effectively skip `b_idx` and look for the next available node.
        for b_idx in banned_set:
            if b_idx < n: # Ensure banned index is within [0, n-1]
                next_available[b_idx] = b_idx + 1

        q = collections.deque()

        # Start BFS from position `p` if it's not banned.
        if p not in banned_set:
            ans[p] = 0
            q.append(p)
            # Mark `p` as visited by updating its DSU parent.
            next_available[p] = p + 1

        while q:
            curr_pos = q.popleft()
            d = ans[curr_pos]

            # Calculate the range of possible starting positions `s` for a subarray of length `k`.
            # The subarray `[s, s+k-1]` must contain `curr_pos`.
            # This implies `s <= curr_pos` and `s >= curr_pos - k + 1`.
            # Also, the subarray must be within array bounds `[0, n-1]`.
            # This implies `s >= 0` and `s + k - 1 <= n - 1` (i.e., `s <= n - k`).
            s_min = max(0, curr_pos - k + 1)
            s_max = min(n - k, curr_pos)

            # Calculate the range of possible next positions `next_pos`.
            # If `curr_pos` is at `s + offset` within `[s, s+k-1]`,
            # after reversal, it moves to `s + (k-1 - offset)`.
            # `offset = curr_pos - s`.
            # So, `next_pos = s + (k-1) - (curr_pos - s) = 2*s + k - 1 - curr_pos`.

            # The smallest possible `next_pos` (when `s` is `s_min`).
            lower_bound_next = 2 * s_min + k - 1 - curr_pos
            # The largest possible `next_pos` (when `s` is `s_max`).
            upper_bound_next = 2 * s_max + k - 1 - curr_pos

            # Iterate through the range `[lower_bound_next, upper_bound_next]`
            # to find unvisited nodes using the DSU structure.

            # Start from the first available node `j` that is `>= lower_bound_next`.
            j = find_next_available(lower_bound_next)

            while j <= upper_bound_next:
                # Ensure `j` is within valid array bounds `[0, n-1]`.
                # `find_next_available` can return `n` or `n+1` if all indices up to `n-1` are visited.
                if j >= n:
                    break

                # If `ans[j]` is -1, it means `j` has not been visited yet (and is not banned).
                if ans[j] == -1:
                    ans[j] = d + 1
                    q.append(j)

                # Mark `j` as visited by updating its DSU parent.
                # This ensures that `find_next_available(j)` will now return `find_next_available(j+1)`
                # in subsequent calls, effectively skipping `j`.
                next_available[j] = j + 1

                # Move to the next available node `j'` that is `>= j + 1`.
                j = find_next_available(j + 1)

        return ans