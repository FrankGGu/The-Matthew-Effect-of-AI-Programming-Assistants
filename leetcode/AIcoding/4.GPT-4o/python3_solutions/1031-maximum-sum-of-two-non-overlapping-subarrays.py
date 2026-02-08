class Solution:
    def maxSumTwoNoOverlap(self, nums: List[int], firstLen: int, secondLen: int) -> int:
        def maxSum(firstLen, secondLen):
            firstSum = sum(nums[:firstLen])
            maxFirstSum = firstSum
            totalMax = 0

            for i in range(firstLen, len(nums)):
                firstSum += nums[i] - nums[i - firstLen]
                maxFirstSum = max(maxFirstSum, firstSum)
                if i >= firstLen + secondLen - 1:
                    totalMax = max(totalMax, maxFirstSum + sum(nums[i - secondLen + 1:i + 1]))

            return totalMax

        return max(maxSum(firstLen, secondLen), maxSum(secondLen, firstLen))