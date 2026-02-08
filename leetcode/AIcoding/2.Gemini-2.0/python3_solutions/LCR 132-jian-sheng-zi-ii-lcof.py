import math

class Solution:
    def minimumRounds(self, bamboo: list[int]) -> int:
        count = 0
        for b in bamboo:
            if b > 0:
                count += 1
        if count == 0:
            return 0

        total_rounds = 0
        for height in bamboo:
            if height == 0:
                continue
            if height == 1:
                return -1
            if height % 3 == 0:
                total_rounds += height // 3
            elif height % 3 == 1:
                if height >= 4:
                    total_rounds += (height - 4) // 3 + 2
                else:
                    return -1
            else:
                total_rounds += height // 3 + 1
        return total_rounds