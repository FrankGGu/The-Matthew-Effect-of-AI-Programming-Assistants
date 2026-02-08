class Solution:
    def findMinFibonacciNumbers(self, k: int) -> int:
        fib = [1, 1]
        while fib[-1] <= k:
            fib.append(fib[-1] + fib[-2])
        fib.pop()

        count = 0
        while k > 0:
            num = max(f for f in fib if f <= k)
            k -= num
            count += 1
        return count