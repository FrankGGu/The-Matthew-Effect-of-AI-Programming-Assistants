import math

class Solution:
    def kthSmallestPath(self, destination: list[int], k: int) -> str:
        row = destination[0]
        col = destination[1]

        r_count = row
        c_count = col

        result = []

        while r_count > 0 or c_count > 0:
            # Calculate the number of paths that would start with 'H'
            # If we place 'H' next, we still need to place r_count 'V's and (c_count - 1) 'H's.
            # The total remaining steps would be (r_count + c_count - 1).
            # The number of ways to arrange these is C(total_remaining_steps, number_of_Vs).
            # If c_count is 0, we cannot place an 'H', and math.comb(n, k) where k > n will return 0.
            # (e.g., math.comb(r_count - 1, r_count) if c_count == 0 and r_count > 0)
            paths_starting_with_H = math.comb(r_count + c_count - 1, r_count)

            if k <= paths_starting_with_H:
                result.append('H')
                c_count -= 1
            else:
                result.append('V')
                r_count -= 1
                k -= paths_starting_with_H

        return "".join(result)