class Solution:
    def punishmentNumber(self, n: int) -> int:
        def is_punishment_number(x):
            s = str(x)
            length = len(s)
            for i in range(1 << (length - 1)):
                total = 0
                current_number = ""
                for j in range(length):
                    current_number += s[j]
                    if i & (1 << j) or j == length - 1:
                        total += int(current_number)
                        current_number = ""
                if total == x:
                    return True
            return False

        return sum(i * i for i in range(1, n + 1) if is_punishment_number(i))