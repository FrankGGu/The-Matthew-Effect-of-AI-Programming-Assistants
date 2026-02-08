class Solution:
    def countEven(self, num: int) -> int:
        count = 0
        for i in range(100, num + 1):
            digits = list(map(int, str(i)))
            if len(digits) == 3 and i % 2 == 0 and len(set(digits)) == 3:
                count += 1
        return count