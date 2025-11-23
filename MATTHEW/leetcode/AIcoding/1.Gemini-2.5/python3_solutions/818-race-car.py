import collections

class Solution:
    def racecar(self, target: int) -> int:
        queue = collections.deque([(0, 1, 0)])  # (position, speed, steps)
        visited = set([(0, 1)])

        while queue:
            pos, speed, steps = queue.popleft()

            if pos == target:
                return steps

            # Option 'A' (Accelerate)
            new_pos_A = pos + speed
            new_speed_A = speed * 2
            if (new_pos_A, new_speed_A) not in visited:
                # Pruning: Only add state if position is within a reasonable range.
                # Common bounds are roughly [-target, 2*target] for position.
                # Speed magnitude can be up to 2 * (smallest power of 2 > target).
                # For target 10^4, 2^14 = 16384. So speed can be up to 32768.
                # Position can go up to 2 * 16384 = 32768.
                # A safe range for pos is typically `0` to `2 * target` or slightly more.
                # And `abs(speed)` up to `2 * target` or slightly more.
                # Let's use a generous range for pruning:
                # If pos is too far negative and speed is negative, it's likely suboptimal.
                # If pos is too far positive and speed is positive, it's likely suboptimal.
                # A simple bound that works for this problem is to keep pos between -target and 2*target.
                if -target <= new_pos_A <= 2 * target:
                    queue.append((new_pos_A, new_speed_A, steps + 1))
                    visited.add((new_pos_A, new_speed_A))

            # Option 'R' (Reverse)
            new_pos_R = pos
            new_speed_R = -1 if speed > 0 else 1
            if (new_pos_R, new_speed_R) not in visited:
                # Position doesn't change with 'R', so it's already within bounds if `pos` was.
                # Speed becomes +/- 1, which is always within valid speed magnitudes.
                queue.append((new_pos_R, new_speed_R, steps + 1))
                visited.add((new_pos_R, new_speed_R))

        return -1 # Should not be reached for valid targets.