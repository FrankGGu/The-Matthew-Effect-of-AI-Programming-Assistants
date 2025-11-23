class Solution:
    def maxStrength(self, nums: List[int]) -> int:
        neg = []
        pos = []
        zero = 0
        for num in nums:
            if num < 0:
                neg.append(num)
            elif num > 0:
                pos.append(num)
            else:
                zero += 1
        neg.sort()
        ans = 1
        if not pos and not neg and zero > 0:
            return 0
        if not pos and len(neg) == 1 and zero > 0:
            return 0
        if not pos and len(neg) == 1:
            return neg[0]

        for num in pos:
            ans *= num

        if len(neg) % 2 == 0:
            for num in neg:
                ans *= num
        else:
            for i in range(len(neg) - 1):
                ans *= neg[i]

        return ans