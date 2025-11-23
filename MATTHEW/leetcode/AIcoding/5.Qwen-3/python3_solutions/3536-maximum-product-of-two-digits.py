class Solution:
    def maxProduct(self, digits: str) -> int:
        max1 = max2 = 0
        for d in digits:
            num = int(d)
            if num > max1:
                max2 = max1
                max1 = num
            elif num > max2:
                max2 = num
        return max1 * max2