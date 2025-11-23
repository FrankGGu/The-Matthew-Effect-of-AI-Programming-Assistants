class Solution:
    def numberToWords(self, num: int) -> str:
        if num == 0:
            return "Zero"

        less_than_20 = ["", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen"]
        tens = ["", "Ten", "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety"]
        thousands = ["", "Thousand", "Million", "Billion"]

        def helper(num):
            if num == 0:
                return ""
            elif num < 20:
                return less_than_20[num]
            elif num < 100:
                return tens[num // 10] + (" " + less_than_20[num % 10] if num % 10 != 0 else "")
            else:
                return less_than_20[num // 100] + " Hundred" + (" " + helper(num % 100) if num % 100 != 0 else "")

        result = ""
        i = 0
        while num > 0:
            if num % 1000 != 0:
                part = helper(num % 1000)
                if i > 0:
                    result = part + " " + thousands[i] + " " + result
                else:
                    result = part + " " + thousands[i]
            num //= 1000
            i += 1

        return result.strip()