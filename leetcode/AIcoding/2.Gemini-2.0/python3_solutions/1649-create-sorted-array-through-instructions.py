class Solution:
    def createSortedArray(self, instructions: List[int]) -> int:
        import bisect
        arr = []
        cost = 0
        for i, num in enumerate(instructions):
            left = bisect.bisect_left(arr, num)
            right = bisect.bisect_right(arr, num)
            cost += min(left, i - right + 1)
            bisect.insort(arr, num)
        return cost % (10**9 + 7)