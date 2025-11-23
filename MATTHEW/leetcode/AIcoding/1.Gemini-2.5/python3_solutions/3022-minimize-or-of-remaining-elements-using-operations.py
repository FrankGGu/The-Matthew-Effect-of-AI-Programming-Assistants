class Solution:
    def minimizeOr(self, nums: list[int]) -> int:
        def check(target_or: int) -> bool:
            current_and = -1 # Represents all bits set, for bitwise AND operations

            for num in nums:
                # Try to extend the current segment by ANDing with num
                # If the result (current_and & num) has any bit set that target_or does not,
                # then this combined segment would violate the condition.
                # The condition is: each segment's AND value must be a submask of target_or.
                if ((current_and & num) | target_or) != target_or:
                    # The current segment cannot include 'num' and satisfy the condition.
                    # So, the current segment must end before 'num'.
                    # 'num' must start a new segment.
                    current_and = num
                    # If 'num' itself is not a submask of target_or, then target_or is impossible.
                    # This means 'num' has a bit set that 'target_or' does not.
                    if (current_and | target_or) != target_or:
                        return False
                else:
                    # The combined segment (current_and & num) is a submask of target_or.
                    # We can extend the current segment.
                    current_and &= num
            return True

        low = 0
        # The maximum possible value for nums[i] is 10^9.
        # The maximum possible OR sum could be the OR of all elements.
        # A safe upper bound for binary search is (1 << 30) - 1, as 10^9 < 2^30.
        high = (1 << 30) - 1 
        ans = high # Initialize ans with the highest possible value

        while low <= high:
            mid = low + (high - low) // 2
            if check(mid):
                ans = mid
                high = mid - 1 # Try to find an even smaller OR sum
            else:
                low = mid + 1 # mid is not achievable, so we need a larger OR sum

        return ans