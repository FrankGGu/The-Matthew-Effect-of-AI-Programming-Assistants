class Solution:
    def doesValidArrayExist(self, derived: List[int]) -> bool:
        n = len(derived)
        original = [0] * n

        for i in range(n - 1):
            original[i + 1] = original[i] ^ derived[i]

        if (original[-1] ^ original[0]) == derived[-1]:
            return True

        original = [1] * n
        for i in range(n - 1):
            original[i + 1] = original[i] ^ derived[i]

        if (original[-1] ^ original[0]) == derived[-1]:
            return True

        return False