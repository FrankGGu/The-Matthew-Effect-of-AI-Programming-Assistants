import bisect

class Solution:
    def minSumDiff(self, nums: list[int]) -> int:
        N = len(nums)
        n = N // 2

        total_sum = sum(nums)

        left_half = nums[:n]
        right_half = nums[n:]

        left_sums = [[] for _ in range(n + 1)]
        right_sums = [[] for _ in range(n + 1)]

        def generate_subset_sums(arr, target_sums_list):
            arr_len = len(arr)
            for i in range(1 << arr_len):
                current_sum = 0
                count = 0
                for j in range(arr_len):
                    if (i >> j) & 1:
                        current_sum += arr[j]
                        count += 1
                target_sums_list[count].append(current_sum)

        generate_subset_sums(left_half, left_sums)
        generate_subset_sums(right_half, right_sums)

        for i in range(n + 1):
            left_sums[i].sort()
            right_sums[i].sort()

        min_diff = float('inf')

        for k in range(n + 1):
            for s1 in left_sums[k]:
                target_s2_list = right_sums[n - k]

                # We want to minimize abs((s1 + s2) - (total_sum - (s1 + s2)))
                # which simplifies to abs(2 * (s1 + s2) - total_sum)

                # To do this, we want s1 + s2 to be as close to total_sum / 2 as possible.
                # So, we are looking for s2 such that s2 is close to (total_sum / 2) - s1.

                target_val_for_s2 = (total_sum / 2) - s1
                idx = bisect.bisect_left(target_s2_list, target_val_for_s2)

                # Check the element at idx (if it exists)
                if idx < len(target_s2_list):
                    current_s2 = target_s2_list[idx]
                    current_partition_sum = s1 + current_s2
                    min_diff = min(min_diff, abs(2 * current_partition_sum - total_sum))

                # Check the element at idx - 1 (if it exists)
                if idx > 0:
                    current_s2 = target_s2_list[idx - 1]
                    current_partition_sum = s1 + current_s2
                    min_diff = min(min_diff, abs(2 * current_partition_sum - total_sum))

        return int(min_diff)