class Solution:
    def maxSum(self, nums: List[int], m: int, k: int) -> int:
        max_sum = 0
        current_sum = 0
        freq = {}
        left = 0

        for right in range(len(nums)):
            num = nums[right]
            current_sum += num
            freq[num] = freq.get(num, 0) + 1

            if right - left + 1 > k:
                left_num = nums[left]
                current_sum -= left_num
                freq[left_num] -= 1
                if freq[left_num] == 0:
                    del freq[left_num]
                left += 1

            if right - left + 1 == k and len(freq) >= m:
                max_sum = max(max_sum, current_sum)

        return max_sum