import heapq

class Solution:
    def nthSuperUglyNumber(self, n: int, primes: List[int]) -> int:
        heap = []
        ugly_numbers = [1]
        seen = {1}

        for prime in primes:
            heapq.heappush(heap, (prime, prime))

        while len(ugly_numbers) < n:
            next_ugly, prime = heapq.heappop(heap)
            if next_ugly != ugly_numbers[-1]:
                ugly_numbers.append(next_ugly)
            seen.add(next_ugly)
            heapq.heappush(heap, (next_ugly * prime, prime))

        return ugly_numbers[-1]