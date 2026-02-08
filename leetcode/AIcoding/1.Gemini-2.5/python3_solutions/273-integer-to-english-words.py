class Solution:
    LESS_THAN_20 = ["", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen"]
    TENS = ["", "Ten", "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety"]
    THOUSANDS = ["", "Thousand", "Million", "Billion"]

    def numberToWords(self, num: int) -> str:
        if num == 0:
            return "Zero"

        result = []
        i = 0
        while num > 0:
            if num % 1000 != 0:
                chunk_words = self._to_words_less_than_1000(num % 1000)
                if i > 0:
                    result.append(chunk_words + " " + self.THOUSANDS[i])
                else:
                    result.append(chunk_words)
            num //= 1000
            i += 1

        return " ".join(result[::-1])

    def _to_words_less_than_1000(self, num: int) -> str:
        if num == 0:
            return ""
        elif num < 20:
            return self.LESS_THAN_20[num]
        elif num < 100:
            return self.TENS[num // 10] + (" " + self.LESS_THAN_20[num % 10] if (num % 10 != 0) else "")
        else: # num < 1000
            return self.LESS_THAN_20[num // 100] + " Hundred" + (" " + self._to_words_less_than_1000(num % 100) if (num % 100 != 0) else "")