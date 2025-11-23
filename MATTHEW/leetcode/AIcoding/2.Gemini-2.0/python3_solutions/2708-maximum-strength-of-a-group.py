class Solution:
    def maxStrength(self, nums: List[int]) -> int:
        pos = []
        neg = []
        zeros = 0
        for num in nums:
            if num > 0:
                pos.append(num)
            elif num < 0:
                neg.append(num)
            else:
                zeros += 1

        if len(pos) == 0 and len(neg) == 0:
            if zeros > 0:
                return 0
            else:
                return 1

        prod = 1
        for num in pos:
            prod *= num

        neg.sort()

        if len(neg) % 2 == 0:
            for num in neg:
                prod *= num
        else:
            if len(neg) > 1:
                for i in range(len(neg) - 1):
                    prod *= neg[i]
            else:
                if len(pos) == 0 and zeros > 0:
                    return 0
                elif len(pos) == 0 and zeros == 0:
                    return neg[0]
                else:
                    prod *= neg[0]

        return prod