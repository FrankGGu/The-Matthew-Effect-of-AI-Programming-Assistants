class Solution:
    def abbreviateProduct(self, left: int, right: int) -> str:
        product = 1
        trailing_zeros = 0
        significant = 1
        length = 0
        mod = 10**9

        for i in range(left, right + 1):
            num = i
            while num % 2 == 0:
                num //= 2
                trailing_zeros += 1
            while num % 5 == 0:
                num //= 5
                trailing_zeros += 1

            product = product * num
            significant = significant * num
            product %= mod

            if significant > 10**10:
                significant //= (10 ** (len(str(significant)) - 10))

        s_prod = str(significant)
        length = len(str(product))

        if length <= 10:
            return str(product) + "e" + str(trailing_zeros)
        else:
            return s_prod[:5] + "..." + s_prod[-5:] + "e" + str(trailing_zeros)