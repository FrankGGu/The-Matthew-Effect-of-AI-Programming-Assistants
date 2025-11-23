import math

class Solution:
    def numDarts(self, darts: list[list[int]], r: int) -> int:
        n = len(darts)
        if n <= 1:
            return n

        max_darts = 1
        r_sq = r * r
        EPSILON = 1e-9 # Small value for floating point comparisons

        # Iterate through each dart as a potential point on the circumference of the optimal dartboard
        for i in range(n):
            p_i = darts[i]

            # current_overlapping_count tracks the number of darts that are identical to p_i.
            # These darts will always be covered if p_i is covered.
            current_overlapping_count = 1 
            events = [] # Stores (angle, type) events for the sweep-line algorithm

            # Consider all other darts p_j
            for j in range(n):
                if i == j:
                    continue

                p_j = darts[j]

                dx = p_j[0] - p_i[0]
                dy = p_j[1] - p_i[1]
                d_sq = dx*dx + dy*dy
                d = math.sqrt(d_sq)

                # If distance between p_i and p_j is greater than 2*r,
                # they cannot both be inside a circle of radius r.
                if d > 2 * r + EPSILON:
                    continue

                # If p_j is effectively the same point as p_i, it's always covered.
                if d <= EPSILON:
                    current_overlapping_count += 1
                    continue

                # Calculate the angle of the vector p_i -> p_j
                alpha = math.atan2(dy, dx)

                # Calculate the half-angle 'phi' of the arc on the circle of radius r centered at p_i
                # where a center C would also cover p_j.
                # cos(phi) = (d/2) / r
                # Use min(1.0, ...) to handle potential floating point errors where d/(2*r) might slightly exceed 1.0
                phi = math.acos(min(1.0, d / (2 * r))) 

                start_angle = alpha - phi
                end_angle = alpha + phi

                # atan2 returns angles in the range (-PI, PI].
                # If end_angle is less than start_angle, it means the arc crosses the -PI/PI boundary.
                # We split it into two segments: [start_angle, PI] and [-PI, end_angle].
                if start_angle > end_angle:
                    events.append((start_angle, +1)) # Start of first segment
                    events.append((math.pi, -1))     # End of first segment (at PI)
                    events.append((-math.pi, +1))    # Start of second segment (at -PI)
                    events.append((end_angle, -1))   # End of second segment
                else:
                    events.append((start_angle, +1))
                    events.append((end_angle, -1))

            # Sort events: first by angle, then by type.
            # For equal angles, process +1 (entry) before -1 (exit) to correctly count maximums.
            events.sort(key=lambda x: (x[0], -x[1]))

            # Initialize current_count with p_i and any darts identical to p_i
            current_count = current_overlapping_count
            max_darts = max(max_darts, current_count)

            # Sweep through the sorted events
            for angle, type_val in events:
                current_count += type_val
                max_darts = max(max_darts, current_count)

        return max_darts