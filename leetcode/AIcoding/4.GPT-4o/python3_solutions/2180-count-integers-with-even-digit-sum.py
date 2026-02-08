class Solution:
    def countEven(self, num: int) -> int:
        return num // 2 + (1 if sum(int(d) for d in str(num)) % 2 == 0 else 0)