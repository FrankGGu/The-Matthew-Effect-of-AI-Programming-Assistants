from collections import Counter

class Solution:
    def findLucky(self, arr: list[int]) -> int:
        counts = Counter(arr)
        lucky_numbers = [num for num, count in counts.items() if num == count]
        if not lucky_numbers:
            return -1
        else:
            return max(lucky_numbers)