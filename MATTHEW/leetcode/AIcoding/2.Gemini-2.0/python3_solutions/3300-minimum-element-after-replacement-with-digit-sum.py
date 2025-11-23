class Solution:
    def minimizeSum(self, nums: List[int], k: int) -> int:
        def digit_sum(n):
            s = 0
            while n:
                s += n % 10
                n //= 10
            return s

        import heapq
        pq = []
        for num in nums:
            heapq.heappush(pq, num)

        while k > 0:
            curr = heapq.heappop(pq)
            ds = digit_sum(curr)
            if ds < curr:
                heapq.heappush(pq, ds)
                k -= 1
            else:
                heapq.heappush(pq, curr)
                break

        return sum(pq)