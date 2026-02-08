class Solution:
    def purchasePlan(self, parts: list[int], target: int) -> int:
        MOD = 1_000_000_007
        parts.sort()

        count = 0
        j = len(parts) - 1

        for i in range(len(parts)):
            while j > i and parts[i] + parts[j] > target:
                j -= 1

            if j <= i:
                break

            # For parts[i], all elements from parts[i+1] to parts[j] form a valid pair.
            # The number of such elements is j - (i + 1) + 1 = j - i.
            count = (count + (j - i)) % MOD

        return count