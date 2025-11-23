class Solution:
    def maximumSwap(self, num: int) -> int:
        digits = list(str(num))
        last_occurrence = {int(d): i for i, d in enumerate(digits)}

        for i, d in enumerate(digits):
            current_digit = int(d)
            for candidate in range(9, current_digit, -1):
                if candidate in last_occurrence and last_occurrence[candidate] > i:
                    digits[i], digits[last_occurrence[candidate]] = digits[last_occurrence[candidate]], digits[i]
                    return int(''.join(digits))
        return num