class Solution:
    def primeSubOperation(self, n: int, A: List[int]) -> bool:
        def is_prime(num):
            if num < 2:
                return False
            for i in range(2, int(num**0.5) + 1):
                if num % i == 0:
                    return False
            return True

        primes = [i for i in range(2, 1000) if is_prime(i)]

        for i in range(len(A) - 1, -1, -1):
            if i == len(A) - 1 or A[i] <= A[i + 1]:
                continue
            for p in primes:
                if A[i] - p > A[i + 1]:
                    A[i] -= p
                    break
            else:
                return False

        return True