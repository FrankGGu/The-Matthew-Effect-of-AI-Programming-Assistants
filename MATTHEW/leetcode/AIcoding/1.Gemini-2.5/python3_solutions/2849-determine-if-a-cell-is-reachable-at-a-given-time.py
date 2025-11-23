class Solution:
    def isReachableAtTime(self, sx: int, sy: int, fx: int, fy: int, t: int) -> bool:
        dx = abs(sx - fx)
        dy = abs(sy - fy)

        min_time_to_reach = max(dx, dy)

        if min_time_to_reach == 0:
            # If start and end cells are the same
            # If t is 0, we are already there.
            # If t > 0, we can stay at the cell for t seconds.
            return True
        else:
            # If start and end cells are different
            # We need at least min_time_to_reach seconds to reach the target.
            # If t is less than min_time_to_reach, it's impossible.
            # If t is greater than or equal to min_time_to_reach, we can reach it
            # in min_time_to_reach steps and then stay at the target cell for the
            # remaining (t - min_time_to_reach) steps.
            return t >= min_time_to_reach