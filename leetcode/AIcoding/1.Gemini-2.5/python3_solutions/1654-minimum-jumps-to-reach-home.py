import collections

class Solution:
    def minimumJumps(self, forbidden: list[int], a: int, b: int, x: int) -> int:
        forbidden_set = set(forbidden)

        # Determine the maximum coordinate to explore.
        # A common upper bound for this problem type is max(x, max(forbidden_pos)) + 2*b.
        # Given x, a, b, forbidden[i] <= 2000.
        # So, max(2000, 2000) + 2 * 2000 = 2000 + 4000 = 6000.
        # Using a slightly larger fixed value to be safe.
        MAX_COORD = 6000 

        # Queue stores (current_position, last_jump_was_backward, num_jumps)
        # last_jump_was_backward: 0 for False (last jump was forward or no jump yet), 1 for True (last jump was backward)
        q = collections.deque([(0, 0, 0)]) 

        # Visited set stores (position, last_jump_was_backward) to avoid cycles and redundant computations.
        # We need to distinguish states where we arrive at the same position but with different last jump directions,
        # as this affects whether we can jump backward next.
        visited = set()
        visited.add((0, 0)) # Start at 0, last jump was not backward (initial state).

        while q:
            curr_pos, last_jump_was_backward, jumps = q.popleft()

            if curr_pos == x:
                return jumps

            # Option 1: Jump forward (a)
            next_pos_forward = curr_pos + a
            if next_pos_forward <= MAX_COORD and \
               next_pos_forward not in forbidden_set and \
               (next_pos_forward, 0) not in visited: # 0 indicates the jump just made was forward

                visited.add((next_pos_forward, 0))
                q.append((next_pos_forward, 0, jumps + 1))

            # Option 2: Jump backward (b)
            # We can only jump backward if the last jump was NOT backward
            # and the next position is non-negative.
            next_pos_backward = curr_pos - b
            if not last_jump_was_backward and \
               next_pos_backward >= 0 and \
               next_pos_backward not in forbidden_set and \
               (next_pos_backward, 1) not in visited: # 1 indicates the jump just made was backward

                visited.add((next_pos_backward, 1))
                q.append((next_pos_backward, 1, jumps + 1))

        # If the queue becomes empty and x was not reached
        return -1