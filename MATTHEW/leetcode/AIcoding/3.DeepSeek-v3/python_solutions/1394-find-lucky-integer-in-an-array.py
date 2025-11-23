from collections import defaultdict

class Solution:
    def findLucky(self, arr: List[int]) -> int:
        freq = defaultdict(int)
        for num in arr:
            freq[num] += 1
        max_lucky = -1
        for num, count in freq.items():
            if num == count and num > max_lucky:
                max_lucky = num
        return max_lucky