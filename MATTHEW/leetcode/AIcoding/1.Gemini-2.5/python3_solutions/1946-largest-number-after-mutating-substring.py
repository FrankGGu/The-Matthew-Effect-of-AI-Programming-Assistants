class Solution:
    def largestNumber(self, num: str, change: list[int]) -> str:
        num_list = list(num)
        n = len(num_list)

        mutating = False

        for i in range(n):
            digit = int(num_list[i])
            changed_digit = change[digit]

            if changed_digit > digit:
                mutating = True
                num_list[i] = str(changed_digit)
            elif changed_digit < digit:
                if mutating:
                    break
            else: # changed_digit == digit
                if mutating:
                    num_list[i] = str(changed_digit)

        return "".join(num_list)