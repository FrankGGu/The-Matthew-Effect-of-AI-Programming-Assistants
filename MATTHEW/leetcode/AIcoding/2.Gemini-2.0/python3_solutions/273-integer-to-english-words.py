class Solution:
    def numberToWords(self, num: int) -> str:
        less_than_20 = ["", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Eleven",
                         "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen"]
        tens = ["", "", "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety"]
        thousands = ["", "Thousand", "Million", "Billion"]

        def helper(n):
            if n < 20:
                return less_than_20[n]
            elif n < 100:
                return tens[n // 10] + (" " + less_than_20[n % 10])
            else:
                return less_than_20[n // 100] + " Hundred " + helper(n % 100)

        if num == 0:
            return "Zero"

        result = []
        for i in range(4):
            if num % 1000 != 0:
                result.append(helper(num % 1000) + " " + thousands[i])
            num //= 1000

        return " ".join(result[::-1]).strip()