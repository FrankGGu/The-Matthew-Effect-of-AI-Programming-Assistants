class Solution:
    def minimumIndex(self, nums: List[int]) -> int:
        n = len(nums)
        total_count = {}
        for num in nums:
            total_count[num] = total_count.get(num, 0) + 1

        left_count = {}
        dominant_index = -1
        for i in range(n - 1):
            left_count[nums[i]] = left_count.get(nums[i], 0) + 1
            total_count[nums[i]] -= 1

            left_dominant = -1
            left_max_count = 0
            for num, count in left_count.items():
                if count > left_max_count:
                    left_max_count = count
                    left_dominant = num

            if left_max_count * 2 <= i + 1:
                continue

            right_dominant = -1
            right_max_count = 0
            for num, count in total_count.items():
                if count > right_max_count:
                    right_max_count = count
                    right_dominant = num

            if right_max_count * 2 <= n - i - 1:
                continue

            if left_dominant == right_dominant:
                return i

        return -1