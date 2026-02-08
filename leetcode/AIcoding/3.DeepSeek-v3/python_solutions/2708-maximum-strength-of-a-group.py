class Solution:
    def maxStrength(self, nums: List[int]) -> int:
        if len(nums) == 1:
            return nums[0]

        positive = []
        negative = []
        zero_count = 0

        for num in nums:
            if num > 0:
                positive.append(num)
            elif num < 0:
                negative.append(num)
            else:
                zero_count += 1

        positive.sort()
        negative.sort()

        max_strength = 1

        if positive:
            for num in positive:
                max_strength *= num

        if len(negative) >= 2:
            for i in range(0, len(negative) - (len(negative) % 2), 2):
                max_strength *= negative[i] * negative[i + 1]

        if max_strength == 1 and not positive and (len(negative) < 2 or zero_count > 0):
            return 0

        return max_strength