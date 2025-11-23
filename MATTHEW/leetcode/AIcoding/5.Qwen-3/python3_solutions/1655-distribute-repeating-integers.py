class Solution:
    def rearrange(self, nums: List[int], k: int) -> bool:
        from collections import Counter
        import heapq

        count = Counter(nums)
        heap = []
        for num, freq in count.items():
            heapq.heappush(heap, (-freq, num))

        result = []
        while heap:
            freq1, num1 = heapq.heappop(heap)
            result.append(num1)
            if len(result) >= k:
                return False
            if freq1 + 1 < 0:
                heapq.heappush(heap, (freq1 + 1, num1))

        return True