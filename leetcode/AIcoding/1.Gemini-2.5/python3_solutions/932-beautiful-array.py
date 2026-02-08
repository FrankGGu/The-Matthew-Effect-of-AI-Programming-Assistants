class Solution:
    def beautifulArray(self, n: int) -> list[int]:
        memo = {1: [1]}

        def generate(N):
            if N in memo:
                return memo[N]

            res = []

            # Generate odd numbers
            # These are derived from a beautiful array of size ceil(N/2)
            # (N + 1) // 2 computes ceil(N/2) for positive integers
            for x in generate((N + 1) // 2):
                res.append(2 * x - 1)

            # Generate even numbers
            # These are derived from a beautiful array of size floor(N/2)
            # N // 2 computes floor(N/2)
            for x in generate(N // 2):
                res.append(2 * x)

            memo[N] = res
            return res

        return generate(n)