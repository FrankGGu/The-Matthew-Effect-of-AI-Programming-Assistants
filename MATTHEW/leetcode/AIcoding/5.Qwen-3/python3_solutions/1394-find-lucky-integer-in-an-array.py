class Solution:
    def findLucky(self, arr: List[int]) -> int:
        from collections import Counter
        count = Counter(arr)
        for num in sorted(count.keys(), reverse=True):
            if count[num] == num:
                return num
        return -1