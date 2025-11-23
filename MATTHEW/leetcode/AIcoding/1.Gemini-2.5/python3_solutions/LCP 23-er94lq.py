class Solution:
    def solve(self, n: int) -> list[int]:
        if n == 0:
            return []
        if n == 1:
            return [1]
        if n % 2 != 0:
            return []

        primes_set = set()
        max_sum = 2 * n - 1
        is_prime_arr = [True] * (max_sum + 1)
        is_prime_arr[0] = is_prime_arr[1] = False
        for p in range(2, max_sum + 1):
            if is_prime_arr[p]:
                primes_set.add(p)
                for multiple in range(p * p, max_sum + 1, p):
                    is_prime_arr[multiple] = False

        ans = []
        path = [0] * n
        used = [False] * (n + 1)

        def backtrack(k):
            if k == n:
                if (path[n - 1] + path[0]) in primes_set:
                    ans.extend(path)
                    return True
                return False

            if k == 0:
                path[0] = 1
                used[1] = True
                if backtrack(k + 1):
                    return True
                # No need to reset path[0] or used[1] as we only try starting with 1
                return False

            for i in range(1, n + 1):
                if not used[i]:
                    if (path[k - 1] + i) in primes_set:
                        path[k] = i
                        used[i] = True
                        if backtrack(k + 1):
                            return True
                        used[i] = False
            return False

        backtrack(0)
        return ans