import collections

class Solution:
    def minimumIndex(self, nums: list[int]) -> int:
        n = len(nums)

        counts = collections.Counter(nums)

        dominant_element = -1
        total_freq_dominant = 0

        for num, freq in counts.items():
            if freq * 2 > n:
                dominant_element = num
                total_freq_dominant = freq
                break

        if dominant_element == -1:
            return -1

        current_freq_left = 0 

        for i in range(n - 1):
            if nums[i] == dominant_element:
                current_freq_left += 1

            len_left = i + 1
            len_right = n - 1 - i

            current_freq_right = total_freq_dominant - current_freq_left

            is_dominant_left = (current_freq_left * 2 > len_left)
            is_dominant_right = (current_freq_right * 2 > len_right)

            if is_dominant_left and is_dominant_right:
                return i

        return -1