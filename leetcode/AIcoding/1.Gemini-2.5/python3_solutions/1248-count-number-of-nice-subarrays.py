class Solution:
    def numberOfSubarrays(self, nums: list[int], k: int) -> int:
        def count_at_most_k(arr: list[int], max_k: int) -> int:
            if max_k < 0:
                return 0

            count = 0
            left = 0
            odd_count = 0

            for right in range(len(arr)):
                if arr[right] % 2 != 0:
                    odd_count += 1

                while odd_count > max_k:
                    if arr[left] % 2 != 0:
                        odd_count -= 1
                    left += 1

                count += (right - left + 1)
            return count

        return count_at_most_k(nums, k) - count_at_most_k(nums, k - 1)