class Solution:
    def unmarkedSumArray(self, nums: List[int], queries: List[List[int]]) -> List[int]:
        import heapq

        n = len(nums)
        marked = [False] * n
        heap = []
        total_sum = sum(nums)
        marked_sum = 0

        for i in range(n):
            heapq.heappush(heap, (nums[i], i))

        res = []
        for index, k in queries:
            if not marked[index]:
                marked[index] = True
                marked_sum += nums[index]

            while k > 0 and heap:
                num, i = heapq.heappop(heap)
                if not marked[i]:
                    marked[i] = True
                    marked_sum += num
                    k -= 1

            res.append(total_sum - marked_sum)

        return res