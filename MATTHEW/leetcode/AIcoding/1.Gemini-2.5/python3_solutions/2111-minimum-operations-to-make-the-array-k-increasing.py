import bisect

class Solution:
    def kIncreasing(self, nums: list[int], k: int) -> int:
        n = len(nums)
        total_operations = 0

        def length_of_longest_non_decreasing_subsequence(arr: list[int]) -> int:
            if not arr:
                return 0

            tails = []
            for num in arr:
                idx = bisect.bisect_right(tails, num)
                if idx == len(tails):
                    tails.append(num)
                else:
                    tails[idx] = num
            return len(tails)

        for i in range(k):
            current_subarray = []
            j = i
            while j < n:
                current_subarray.append(nums[j])
                j += k

            lnds_length = length_of_longest_non_decreasing_subsequence(current_subarray)
            total_operations += len(current_subarray) - lnds_length

        return total_operations