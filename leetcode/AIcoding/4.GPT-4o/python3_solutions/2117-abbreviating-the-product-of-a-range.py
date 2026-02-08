class Solution:
    def abbreviateProduct(self, left: int, right: int) -> str:
        from math import log10

        product = 1
        for i in range(left, right + 1):
            product *= i

        product_str = str(product)
        if len(product_str) <= 10:
            return product_str

        prefix = product_str[:3]
        suffix = product_str[-3:]
        num_digits = len(product_str)
        abbreviated = f"{prefix}...{suffix}e{num_digits - 1}"

        return abbreviated