class Solution:
    def largestPalindromic(self, num: str) -> str:
        count = [0] * 10
        for c in num:
            count[int(c)] += 1

        first_part = []
        for d in range(9, -1, -1):
            while count[d] > 1:
                if not first_part and d == 0:
                    break
                first_part.append(str(d))
                count[d] -= 2

        mid = []
        for d in range(9, -1, -1):
            if count[d] > 0:
                mid.append(str(d))
                break

        if not first_part and not mid:
            return "0"

        second_part = first_part[::-1]
        res = ''.join(first_part + mid + second_part)
        return res