class Solution:
    def findMinFibonacciNumbers(self, k: int) -> int:
        fib = [1, 2]
        while fib[-1] <= k:
            fib.append(fib[-1] + fib[-2])

        count = 0
        for num in reversed(fib):
            if k == 0:
                break
            if num <= k:
                k -= num
                count += 1

        return count