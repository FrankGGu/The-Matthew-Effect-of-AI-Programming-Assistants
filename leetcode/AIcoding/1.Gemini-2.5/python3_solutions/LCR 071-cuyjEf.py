import random
import bisect

class Solution:

    def __init__(self, w: list[int]):
        self.prefix_sums = []
        current_sum = 0
        for weight in w:
            current_sum += weight
            self.prefix_sums.append(current_sum)

    def pickIndex(self) -> int:
        total_sum = self.prefix_sums[-1]
        target = random.randint(1, total_sum)

        return bisect.bisect_left(self.prefix_sums, target)