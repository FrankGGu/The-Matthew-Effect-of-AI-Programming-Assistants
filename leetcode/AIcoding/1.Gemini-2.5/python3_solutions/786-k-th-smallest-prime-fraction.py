class Solution:
    def kthSmallestPrimeFraction(self, arr: list[int], k: int) -> list[int]:
        n = len(arr)

        def check(mid_val):
            count = 0
            max_fraction_val = 0.0
            best_numerator = arr[0]
            best_denominator = arr[n - 1]

            i = 0  # Pointer for numerator index
            for j in range(1, n):  # Pointer for denominator index
                # For current arr[j], find how many arr[i] (i < j) satisfy arr[i] / arr[j] <= mid_val
                # This is equivalent to arr[i] <= mid_val * arr[j]
                while i < j and arr[i] <= mid_val * arr[j]:
                    # This fraction arr[i]/arr[j] is <= mid_val.
                    # We want to keep track of the largest such fraction encountered.
                    current_fraction_val = arr[i] / arr[j]
                    if current_fraction_val > max_fraction_val:
                        max_fraction_val = current_fraction_val
                        best_numerator = arr[i]
                        best_denominator = arr[j]
                    i += 1

                # After the while loop, 'i' is the count of numerators (0 to i-1)
                # for arr[j] that satisfy arr[x]/arr[j] <= mid_val.
                count += i

            return count, [best_numerator, best_denominator]

        low = 0.0
        high = 1.0
        ans = [arr[0], arr[n - 1]] # Initialize with the smallest possible fraction

        # Binary search for the K-th smallest fraction value
        # 100 iterations are typically sufficient for float precision in such problems
        for _ in range(100): 
            mid = (low + high) / 2

            count, current_ans = check(mid)

            if count < k:
                # If there are fewer than k fractions <= mid,
                # the K-th smallest must be greater than mid.
                low = mid
            else:
                # If there are k or more fractions <= mid,
                # mid could be the K-th smallest, or it's too high.
                # We record the largest fraction found so far that is <= mid
                # as a potential answer, and try to find a smaller mid.
                ans = current_ans
                high = mid

        return ans