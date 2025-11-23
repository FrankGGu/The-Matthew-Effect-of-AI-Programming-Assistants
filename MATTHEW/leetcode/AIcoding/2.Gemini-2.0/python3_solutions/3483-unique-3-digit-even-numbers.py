class Solution:
    def findEvenNumbers(self, digits: list[int]) -> list[int]:
        count = {}
        for digit in digits:
            count[digit] = count.get(digit, 0) + 1

        result = []
        for i in range(100, 1000, 2):
            s = str(i)
            temp_count = {}
            valid = True
            for digit in s:
                digit = int(digit)
                temp_count[digit] = temp_count.get(digit, 0) + 1
                if temp_count[digit] > count.get(digit, 0):
                    valid = False
                    break

            if valid and s[0] != '0':
                result.append(i)

        return sorted(list(set(result)))