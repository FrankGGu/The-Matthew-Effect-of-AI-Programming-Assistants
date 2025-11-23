import bisect

class Solution:
    def medianOfUniquenessArray(self, nums: List[int]) -> int:
        n = len(nums)
        total_subarrays = n * (n + 1) // 2
        median_pos = (total_subarrays + 1) // 2

        def count_subarrays_with_at_most_k_distinct(k):
            count = 0
            freq = {}
            left = 0
            distinct = 0
            for right in range(n):
                num = nums[right]
                if freq.get(num, 0) == 0:
                    distinct += 1
                freq[num] = freq.get(num, 0) + 1

                while distinct > k:
                    left_num = nums[left]
                    freq[left_num] -= 1
                    if freq[left_num] == 0:
                        distinct -= 1
                    left += 1
                count += right - left + 1
            return count

        left = 1
        right = len(set(nums))
        answer = right
        while left <= right:
            mid = (left + right) // 2
            if count_subarrays_with_at_most_k_distinct(mid) >= median_pos:
                answer = mid
                right = mid - 1
            else:
                left = mid + 1
        return answer