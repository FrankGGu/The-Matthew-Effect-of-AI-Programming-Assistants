class Solution:
    def brokenCalc(self, startValue: int, target: int) -> int:
        operations = 0
        while target > startValue:
            operations += 1
            if target % 2 == 0:
                target //= 2
            else:
                target += 1
        operations += startValue - target
        return operations