import collections

class Solution:
    def medianOfUniquenessArray(self, nums: list[int]) -> int:
        n = len(nums)

        # Calculate the total number of subarrays
        total_subarrays = n * (n + 1) // 2

        # The target rank for the median (1-indexed)
        # If total_subarrays is even, problem states to take the smaller of the two middle values.
        # This corresponds to the (total_subarrays + 1) // 2 -th element.
        target_rank = (total_subarrays + 1) // 2

        # Function to count subarrays with at most `k_val` unique elements
        def count_at_most_k(k_val: int) -> int:
            if k_val == 0:
                return 0

            count = 0
            left = 0
            freq = collections.defaultdict(int)
            unique_count = 0

            for right in range(n):
                num_r = nums[right]
                freq[num_r] += 1
                if freq[num_r] == 1:
                    unique_count += 1

                # Shrink window from left if unique_count exceeds k_val
                while unique_count > k_val:
                    num_l = nums[left]
                    freq[num_l] -= 1
                    if freq[num_l] == 0:
                        unique_count -= 1
                    left += 1

                # All subarrays ending at 'right' and starting from 'left' to 'right'
                # have at most k_val unique elements.
                count += (right - left + 1)
            return count

        # Binary search for the median value
        # The possible range for unique counts is [1, n]
        low = 1
        high = n
        ans = n # Initialize with a possible maximum value

        while low <= high:
            mid = low + (high - low) // 2

            # If there are at least `target_rank` subarrays with at most `mid` unique elements,
            # then `mid` could be our answer, or we might find a smaller one.
            if count_at_most_k(mid) >= target_rank:
                ans = mid
                high = mid - 1
            else:
                # `mid` is too small, we need more unique elements.
                low = mid + 1

        return ans