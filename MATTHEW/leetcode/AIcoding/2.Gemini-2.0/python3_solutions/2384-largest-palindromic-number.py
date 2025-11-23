class Solution:
    def largestPalindromic(self, num: str) -> str:
        counts = [0] * 10
        for digit in num:
            counts[int(digit)] += 1

        largest = ""
        for i in range(9, -1, -1):
            if counts[i] >= 2:
                count = counts[i] // 2
                largest += str(i) * count
                counts[i] -= count * 2

        if not largest:
            max_single = -1
            for i in range(9, -1, -1):
                if counts[i] > 0:
                    max_single = i
                    break
            if max_single == -1:
                return "0"
            else:
                return str(max_single)

        middle = ""
        for i in range(9, -1, -1):
            if counts[i] > 0:
                middle = str(i)
                break

        if largest[0] == '0':
            return "0"

        return largest + middle + largest[::-1]