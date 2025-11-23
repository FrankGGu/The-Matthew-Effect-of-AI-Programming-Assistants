class Solution:
    def rangeSum(self, nums: List[int], n: int, left: int, right: int, k: int) -> int:
        import heapq

        min_heap = []
        for i in range(n):
            heapq.heappush(min_heap, (nums[i], i, 1))

        result = 0
        for _ in range(right):
            val, idx, count = heapq.heappop(min_heap)
            if _ + 1 >= left:
                result += val
            if idx + count < n:
                heapq.heappush(min_heap, (val + nums[idx + count], idx, count + 1))

        return result % (10**9 + 7)