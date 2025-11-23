class Solution:
    def maximumCandies(self, candies: list[int], k: int) -> int:

        def check(x: int) -> bool:
            if x == 0:  # If x is 0, we can theoretically give infinite children 0 candies.
                        # But problem asks for maximum positive integer x, or 0 if not possible.
                        # Our binary search starts from 1, so x will be >= 1.
                return True 

            total_children = 0
            for pile in candies:
                total_children += pile // x
            return total_children >= k

        left = 0  # Minimum possible candies per child
        right = max(candies) if candies else 0 # Maximum possible candies per child (can't exceed largest pile)
                                               # If candies is empty, max is 0.
        ans = 0

        while left <= right:
            mid = left + (right - left) // 2

            # If mid is 0, and we are checking it, it means we can give 0 candies to everyone.
            # This is always possible. We want the largest possible positive integer.
            # If mid is 0, we should try to increase it to find a positive answer.
            # However, our binary search range starts from 0 for `left` and `ans` is initialized to 0.
            # If `check(0)` were called, it would technically be true, but we want the largest `x`
            # such that `x` candies can be given.
            # The `check` function is designed for `x >= 1`. If `mid` becomes 0, it means no positive `x` works.
            # Let's refine `left` to 1 if we want strictly positive answers initially, but 0 is a valid answer.
            # The current setup works: if `mid` is 0, `check(0)` would return true, `ans` becomes 0, `left` becomes 1.
            # The search continues for positive values. If no positive value works, `ans` stays 0.

            if mid == 0: # special handling for mid=0 to avoid division by zero and correctly find max positive
                if check(1): # If even 1 candy per child is possible, we should try for more.
                    ans = max(ans, mid) # ans can be 0.
                    left = mid + 1 # Try for 1 or more.
                else: # If not even 1 candy per child is possible, then 0 is the only option.
                    right = mid - 1 # This path means we can't even get 1 candy per child.
                                    # So, the maximum is 0.
                continue

            if check(mid):
                ans = mid
                left = mid + 1  # Try to find a larger number of candies per child
            else:
                right = mid - 1 # Need to reduce the number of candies per child

        return ans