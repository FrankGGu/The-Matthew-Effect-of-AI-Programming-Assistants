import heapq

class Solution:
    def nthSuperUglyNumber(self, n: int, primes: List[int]) -> int:
        heap = [1]
        seen = {1}

        for _ in range(n):
            ugly = heapq.heappop(heap)

            if _ == n - 1:
                return ugly

            for prime in primes:
                next_ugly = ugly * prime
                if next_ugly not in seen:
                    heapq.heappush(heap, next_ugly)
                    seen.add(next_ugly)