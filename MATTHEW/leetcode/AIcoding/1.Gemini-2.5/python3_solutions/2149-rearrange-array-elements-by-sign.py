class Solution:
    def rearrangeArray(self, nums: list[int]) -> list[int]:
        positives = []
        negatives = []
        for num in nums:
            if num > 0:
                positives.append(num)
            else:
                negatives.append(num)

        result = [0] * len(nums)

        for i in range(len(positives)):
            result[2 * i] = positives[i]
            result[2 * i + 1] = negatives[i]

        return result