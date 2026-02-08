class Solution:
    def minimumIndex(self, nums: List[int]) -> int:
        count = Counter(nums)
        max_num, max_count = max(count.items(), key=lambda x: x[1])

        left_count = 0
        left_size = 0

        for i in range(len(nums)):
            if nums[i] == max_num:
                left_count += 1
            left_size += 1

            if left_count * 2 > left_size:
                break

            right_count = count[max_num] - left_count
            right_size = len(nums) - left_size

            if right_count * 2 > right_size:
                return i

        return -1