class Solution:
    def getBeauty(self, nums: list[int], k: int, x: int) -> list[int]:
        n = len(nums)
        result = []
        # counts array to store frequencies of numbers in the current window.
        # It maps value -50 to index 0, 0 to index 50, and 50 to index 100.
        counts = [0] * 101 

        def find_xth_smallest_beauty(current_counts, target_x):
            current_count_sum = 0
            # Iterate through possible values from smallest (-50) to largest (50)
            for j in range(101):
                current_count_sum += current_counts[j]
                # If we have accumulated enough elements to reach the target_x-th smallest
                if current_count_sum >= target_x:
                    val = j - 50  # Convert index back to original value
                    # Apply the beauty rule: if negative, use the value; otherwise, 0.
                    return val if val < 0 else 0
            return 0 # This line should theoretically not be reached given problem constraints (1 <= x <= k)

        # Initialize the first window
        for i in range(k):
            counts[nums[i] + 50] += 1

        # Calculate beauty for the first window
        result.append(find_xth_smallest_beauty(counts, x))

        # Slide the window
        for i in range(k, n):
            # Remove the element leaving the window (nums[i-k])
            counts[nums[i - k] + 50] -= 1
            # Add the element entering the window (nums[i])
            counts[nums[i] + 50] += 1

            # Calculate beauty for the current window
            result.append(find_xth_smallest_beauty(counts, x))

        return result