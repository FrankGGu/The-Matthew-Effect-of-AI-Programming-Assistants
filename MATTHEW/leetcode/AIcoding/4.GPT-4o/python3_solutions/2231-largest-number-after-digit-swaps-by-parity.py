class Solution:
    def largestInteger(self, num: int) -> int:
        even_digits = sorted([int(d) for d in str(num) if int(d) % 2 == 0], reverse=True)
        odd_digits = sorted([int(d) for d in str(num) if int(d) % 2 != 0], reverse=True)

        result = []
        for d in str(num):
            if int(d) % 2 == 0:
                result.append(str(even_digits.pop(0)))
            else:
                result.append(str(odd_digits.pop(0)))

        return int(''.join(result))