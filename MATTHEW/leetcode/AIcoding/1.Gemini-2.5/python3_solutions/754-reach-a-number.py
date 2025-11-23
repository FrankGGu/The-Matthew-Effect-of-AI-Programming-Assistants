class Solution:
    def reachNumber(self, target: int) -> int:
        target = abs(target)
        k = 0
        current_sum = 0
        while True:
            k += 1
            current_sum += k
            if current_sum >= target and (current_sum - target) % 2 == 0:
                return k