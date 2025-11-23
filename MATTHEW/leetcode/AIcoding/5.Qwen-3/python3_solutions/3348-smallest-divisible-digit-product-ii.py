class Solution:
    def smallestRepunitDivByEqv(self, target: int) -> int:
        seen = set()
        remainder = 1 % target
        length = 1
        while remainder != 0:
            if remainder in seen:
                return -1
            seen.add(remainder)
            remainder = (remainder * 10 + 1) % target
            length += 1
        return length