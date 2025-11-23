class Solution:
    def abbreviateProduct(self, left: int, right: int) -> str:
        product = 1
        zeros = 0
        for num in range(left, right + 1):
            product *= num
            while product % 10 == 0:
                product //= 10
                zeros += 1
            if product > 10**20:
                product %= 10**20

        if product < 10**10:
            return f"{product}e{zeros}"
        else:
            first_five = str(product)[:5]
            last_five = str(product)[-5:]
            return f"{first_five}...{last_five}e{zeros}"