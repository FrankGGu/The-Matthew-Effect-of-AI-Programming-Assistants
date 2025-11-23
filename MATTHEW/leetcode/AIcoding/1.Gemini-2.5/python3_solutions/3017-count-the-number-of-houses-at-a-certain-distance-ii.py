class Solution:
    def countOfPairs(self, n: int, x: int, y: int) -> list[int]:
        # Ensure x is always less than or equal to y for consistency.
        # The absolute difference and circular distance calculations handle order correctly,
        # but this standardization can simplify mental models.
        if x > y:
            x, y = y, x

        # ans[k] will store the count for distance k.
        # Valid distances are from 1 to n-1.
        # We initialize an array of size n, so ans[0] will be unused and
        # ans[1] through ans[n-1] will store the counts.
        ans = [0] * n 

        # Helper function to calculate the shortest distance between two houses
        # on a circular arrangement of n houses.
        def get_circular_dist(a, b, n_val):
            # Distance along one arc
            d_straight = abs(a - b)
            # Distance along the other arc
            d_wrap_around = n_val - d_straight
            return min(d_straight, d_wrap_around)

        # Iterate through all unique pairs of houses (i, j)
        for i in range(1, n + 1):
            for j in range(i + 1, n + 1):
                # Calculate the shortest distance between house i and house j.
                # There are three possible types of paths:

                # Path 1: Directly on the circle, without using the special x-y road.
                dist_direct_circle = get_circular_dist(i, j, n)

                # Path 2: Using the special x-y road.
                # This path goes from i to x (circularly), then takes the x-y road (cost 1),
                # then goes from y to j (circularly).
                dist_via_xy = get_circular_dist(i, x, n) + 1 + get_circular_dist(y, j, n)

                # Path 3: Using the special x-y road in the reverse direction.
                # This path goes from i to y (circularly), then takes the y-x road (cost 1),
                # then goes from x to j (circularly).
                dist_via_yx = get_circular_dist(i, y, n) + 1 + get_circular_dist(x, j, n)

                # The actual shortest distance is the minimum of these three paths.
                actual_dist = min(dist_direct_circle, dist_via_xy, dist_via_yx)

                # Increment the count for this calculated distance.
                # Since actual_dist will be between 1 and n-1, it directly maps to the index.
                ans[actual_dist] += 1

        # Return the counts for distances from 1 to n-1.
        # ans[0] is not used for any valid distance, so we slice the array.
        return ans[1:]