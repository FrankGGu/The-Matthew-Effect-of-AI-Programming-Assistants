class Solution:
    def minAbsDifference(self, nums: List[int], goal: int) -> int:
        n = len(nums)
        half = n // 2

        def generate_sums(arr):
            sums = {0}
            for num in arr:
                new_sums = set()
                for s in sums:
                    new_sums.add(s + num)
                sums.update(new_sums)
            return sorted(sums)

        left_sums = generate_sums(nums[:half])
        right_sums = generate_sums(nums[half:])

        min_diff = float('inf')
        left, right = 0, len(right_sums) - 1

        while left < len(left_sums) and right >= 0:
            current_sum = left_sums[left] + right_sums[right]
            min_diff = min(min_diff, abs(current_sum - goal))
            if current_sum < goal:
                left += 1
            elif current_sum > goal:
                right -= 1
            else:
                return 0

        return min_diff