class Solution:
    def sumOfImbalanceNumbers(self, nums: List[int]) -> int:
        n = len(nums)
        total = 0

        for i in range(n):
            left_count = {}
            right_count = {}
            for j in range(i, n):
                if nums[j] not in right_count:
                    right_count[nums[j]] = 0
                right_count[nums[j]] += 1

                if j > i:
                    total += (len(right_count) - len(left_count) - (1 if nums[j-1] in left_count else 0))

                left_count[nums[j]] = left_count.get(nums[j], 0) + 1

        return total