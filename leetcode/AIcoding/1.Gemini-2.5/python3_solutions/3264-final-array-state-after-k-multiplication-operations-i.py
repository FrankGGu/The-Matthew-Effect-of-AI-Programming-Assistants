class Solution:
    def finalArrayState(self, n: int, k: int) -> list[int]:
        q = k // n  # Base exponent for most elements
        r = k % n   # Number of elements that get an additional multiplication

        result = []

        # r elements will have an exponent of q + 1
        # These elements are 2^(q+1)
        if r > 0:
            val_q_plus_1 = 2**(q + 1)
            for _ in range(r):
                result.append(val_q_plus_1)

        # The remaining (n - r) elements will have an exponent of q
        # These elements are 2^q
        if n - r > 0:
            val_q = 2**q
            for _ in range(n - r):
                result.append(val_q)

        return result