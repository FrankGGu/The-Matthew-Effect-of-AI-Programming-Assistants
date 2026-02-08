class Solution:
    def maxStrength(self, nums: List[int]) -> int:
        positives = []
        negatives = []
        zeros = 0
        for num in nums:
            if num > 0:
                positives.append(num)
            elif num < 0:
                negatives.append(num)
            else:
                zeros += 1

        product = 1

        if len(positives) == 0 and len(negatives) == 0 and zeros > 0:
            return 0

        if len(positives) == 0 and len(negatives) == 1 and zeros > 0:
            return 0

        negatives.sort()

        if len(negatives) % 2 != 0:
            if len(negatives) > 1:
                negatives.pop()
            elif len(positives) == 0 and zeros == 0:
                return negatives[0]
            elif len(positives) == 0 and zeros > 0:
                return 0

        for num in positives:
            product *= num

        for num in negatives:
            product *= num

        return product