import heapq

class Solution:
    def kthLargestNumber(self, nums: List[str], k: int) -> str:
        return heapq.nlargest(k, nums, key=int)[-1]