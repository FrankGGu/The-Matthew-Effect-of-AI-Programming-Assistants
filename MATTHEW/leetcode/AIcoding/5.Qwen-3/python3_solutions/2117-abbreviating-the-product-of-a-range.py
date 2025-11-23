class Solution:
    def abbreviateProduct(self, left: int, right: int) -> str:
        from math import log10

        product = 1
        count = 0
        for i in range(left, right + 1):
            product *= i
            while product >= 10**9:
                product //= 10
                count += 1
        if count < 8:
            return str(product)
        else:
            total_log = sum(log10(i) for i in range(left, right + 1))
            leading = int(10**(total_log - count + 9))
            return f"{leading}e{count}"