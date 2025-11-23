class Solution:
    def multiply(self, num1: str, num2: str) -> str:
        if num1 == "0" or num2 == "0":
            return "0"

        m, n = len(num1), len(num2)
        result = [0] * (m + n)

        for i in range(m - 1, -1, -1):
            d1 = int(num1[i])
            for j in range(n - 1, -1, -1):
                d2 = int(num2[j])

                product = d1 * d2

                # The product of num1[i] and num2[j] contributes to positions i+j and i+j+1
                # i+j+1 is the current digit's position (units place for this product)
                # i+j is the carry position (tens place for this product)

                # Add the product to the existing value at result[i+j+1]
                # This handles any carry from previous calculations at this position
                current_sum = product + result[i + j + 1]

                # Update the digit at result[i+j+1]
                result[i + j + 1] = current_sum % 10
                # Add the carry to the next significant digit position
                result[i + j] += current_sum // 10

        # Convert the list of digits to a string
        # Find the first non-zero digit to handle leading zeros
        start_index = 0
        while start_index < len(result) - 1 and result[start_index] == 0:
            start_index += 1

        return "".join(map(str, result[start_index:]))