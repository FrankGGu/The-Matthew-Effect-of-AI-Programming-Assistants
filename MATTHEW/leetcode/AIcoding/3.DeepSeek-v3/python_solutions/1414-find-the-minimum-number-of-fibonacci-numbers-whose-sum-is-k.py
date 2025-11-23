class Solution:
    def findMinFibonacciNumbers(self, k: int) -> int:
        fib = [1, 1]
        while fib[-1] < k:
            fib.append(fib[-1] + fib[-2])

        count = 0
        remaining = k
        for num in reversed(fib):
            if num <= remaining:
                remaining -= num
                count += 1
                if remaining == 0:
                    break
        return count