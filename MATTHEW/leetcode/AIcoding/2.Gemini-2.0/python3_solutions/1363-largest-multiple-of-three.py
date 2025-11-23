class Solution:
    def largestMultipleOfThree(self, digits: List[int]) -> str:
        remainders = [[] for _ in range(3)]
        total_sum = 0
        for digit in digits:
            remainders[digit % 3].append(digit)
            total_sum += digit

        for i in range(3):
            remainders[i].sort()

        rem = total_sum % 3

        if rem != 0:
            if len(remainders[rem]) > 0:
                remainders[rem].pop(0)
            else:
                if len(remainders[3 - rem]) >= 2:
                    remainders[3 - rem].pop(0)
                    remainders[3 - rem].pop(0)
                else:
                    return ""

        result = []
        for i in range(3):
            result.extend(remainders[i])

        result.sort(reverse=True)

        if not result:
            return ""

        res_str = "".join(map(str, result))

        if res_str[0] == '0':
            return "0"

        return res_str