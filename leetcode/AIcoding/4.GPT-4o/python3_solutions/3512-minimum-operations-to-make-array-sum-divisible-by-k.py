class Solution:
    def minOperations(self, A: List[int], K: int) -> int:
        total_sum = sum(A)
        mod = total_sum % K

        if mod == 0:
            return 0

        count = 0
        freq = {}

        for a in A:
            remainder = a % K
            if remainder != 0:
                needed = (K - (mod - remainder) % K) % K
                count += freq.get(needed, 0)
                freq[remainder] = freq.get(remainder, 0) + 1

        return count if count > 0 else -1