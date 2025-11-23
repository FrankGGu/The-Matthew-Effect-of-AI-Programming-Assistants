class Solution:
    def checkSubarraySum(self, nums: list[int], k: int) -> bool:
        if k == 0:
            # For k=0, we need a subarray of size at least 2 that sums to 0.
            # This is equivalent to finding two prefix sums that are equal,
            # with indices differing by at least 2.
            prefix_sums = {0: -1}  # Map sum -> index
            current_sum = 0
            for i in range(len(nums)):
                current_sum += nums[i]
                if current_sum in prefix_sums:
                    if i - prefix_sums[current_sum] >= 2:
                        return True
                else:
                    prefix_sums[current_sum] = i
            return False

        # For k != 0, we are looking for (sum_j - sum_i) % k == 0,
        # which means sum_j % k == sum_i % k.
        # We use a hash map to store (remainder % k) -> index.
        # Initialize with {0: -1} to handle cases where the subarray starts from index 0
        # and its sum is a multiple of k.
        remainder_map = {0: -1}
        current_sum = 0

        for i in range(len(nums)):
            current_sum += nums[i]
            remainder = current_sum % k

            if remainder in remainder_map:
                # If the current remainder has been seen before at prev_index,
                # it means the sum of elements between prev_index and i (inclusive)
                # is a multiple of k.
                # The length of this subarray is i - prev_index.
                if i - remainder_map[remainder] >= 2:
                    return True
            else:
                # Store the first occurrence of this remainder.
                remainder_map[remainder] = i

        return False