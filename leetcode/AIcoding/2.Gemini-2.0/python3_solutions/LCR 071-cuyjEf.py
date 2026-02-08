import random
import bisect

class Solution:

    def __init__(self, w: list[int]):
        self.prefix_sums = []
        sum = 0
        for weight in w:
            sum += weight
            self.prefix_sums.append(sum)
        self.total_sum = sum

    def pickIndex(self) -> int:
        random_num = random.random() * self.total_sum
        index = bisect.bisect_left(self.prefix_sums, random_num)
        return index