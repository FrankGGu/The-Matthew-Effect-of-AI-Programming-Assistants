class Solution:
    def numberToWords(self, num: int) -> str:
        if num == 0:
            return "Zero"

        def one(num):
            switcher = {
                1: "One", 2: "Two", 3: "Three", 4: "Four", 5: "Five",
                6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
            }
            return switcher.get(num, "")

        def two_less_20(num):
            switcher = {
                10: "Ten", 11: "Eleven", 12: "Twelve", 13: "Thirteen", 
                14: "Fourteen", 15: "Fifteen", 16: "Sixteen", 
                17: "Seventeen", 18: "Eighteen", 19: "Nineteen"
            }
            return switcher.get(num, "")

        def tens(num):
            switcher = {
                2: "Twenty", 3: "Thirty", 4: "Forty", 
                5: "Fifty", 6: "Sixty", 7: "Seventy", 
                8: "Eighty", 9: "Ninety"
            }
            return switcher.get(num, "")

        def two(num):
            if num == 0:
                return ""
            elif num < 10:
                return one(num)
            elif num < 20:
                return two_less_20(num)
            else:
                tenner = num // 10
                rest = num % 10
                return tens(tenner) + (" " + one(rest) if rest != 0 else "")

        def three(num):
            hundred = num // 100
            rest = num % 100
            if hundred == 0:
                return two(rest)
            else:
                return one(hundred) + " Hundred" + (" " + two(rest) if rest != 0 else "")

        billions = num // 1000000000
        millions = (num // 1000000) % 1000
        thousands = (num // 1000) % 1000
        hundreds = num % 1000

        result = []
        if billions:
            result.append(three(billions) + " Billion")
        if millions:
            result.append(three(millions) + " Million")
        if thousands:
            result.append(three(thousands) + " Thousand")
        if hundreds:
            result.append(three(hundreds))

        return " ".join(result)