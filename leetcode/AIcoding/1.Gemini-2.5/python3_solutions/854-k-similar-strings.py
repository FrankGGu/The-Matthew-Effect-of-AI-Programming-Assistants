import collections

class Solution:
    def kSimilarity(self, s1: str, s2: str) -> int:
        n = len(s1)

        # BFS queue stores (current_string, number_of_swaps)
        queue = collections.deque([(s1, 0)])
        visited = {s1}

        while queue:
            curr_s_tuple, k = queue.popleft()

            # Convert tuple to list for mutable operations
            curr_s_list = list(curr_s_tuple)

            if curr_s_tuple == s2:
                return k

            # Find the first index 'i' where curr_s[i] differs from s2[i]
            i = 0
            while i < n and curr_s_list[i] == s2[i]:
                i += 1

            # If i == n, curr_s_tuple is already s2, handled by the check above.
            # We only need to consider swaps that involve curr_s_list[i]
            # We look for a character s2[i] at some position j > i
            # and swap curr_s_list[i] with curr_s_list[j]
            for j in range(i + 1, n):
                # Optimization: Only consider swaps where curr_s_list[j] is the character
                # that should be at position 'i' (i.e., s2[i]).
                # Also, curr_s_list[j] should not already be in its correct place (s2[j]),
                # as swapping it out would be inefficient unless it's part of a cycle.
                # The condition `curr_s_list[j] == s2[i]` is the primary optimization.
                # The condition `curr_s_list[j] != s2[j]` is a further optimization:
                # If curr_s_list[j] is already s2[j], swapping it with curr_s_list[i]
                # (which is not s2[i]) would make position j incorrect.
                # This is only useful if curr_s_list[i] is also s2[j], forming a direct swap.
                # Without this condition, it still works, but might explore more states.
                # For this problem, `curr_s_list[j] == s2[i]` is sufficient for correctness and performance.
                if curr_s_list[j] == s2[i]:
                    # Perform the swap to create the next string
                    next_s_list = list(curr_s_list) # Create a copy to modify
                    next_s_list[i], next_s_list[j] = next_s_list[j], next_s_list[i]
                    next_s_tuple = tuple(next_s_list) # Convert to tuple for hashability

                    if next_s_tuple not in visited:
                        visited.add(next_s_tuple)
                        queue.append((next_s_tuple, k + 1))

        return -1 # Should not be reached as s1 and s2 are anagrams