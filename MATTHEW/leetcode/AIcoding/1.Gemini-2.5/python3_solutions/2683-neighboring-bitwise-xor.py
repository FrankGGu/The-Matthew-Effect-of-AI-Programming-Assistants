class Solution:
    def canBeDerived(self, derived: list[int]) -> bool:
        n = len(derived)

        def check(start_val):
            original = [0] * n
            original[0] = start_val

            for i in range(n - 1):
                original[i+1] = derived[i] ^ original[i]

            return derived[n-1] == (original[n-1] ^ original[0])

        if n == 1:
            return derived[0] == 0

        if check(0):
            return True

        if check(1):
            return True

        return False