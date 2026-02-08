class Solution:
    def canArrange(self, arr: list[int], k: int) -> bool:
        remainder_counts = [0] * k

        for num in arr:
            remainder_counts[num % k] += 1

        if remainder_counts[0] % 2 != 0:
            return False

        for r in range(1, k // 2 + 1):
            if r == k - r: 
                if remainder_counts[r] % 2 != 0:
                    return False
            else:
                if remainder_counts[r] != remainder_counts[k - r]:
                    return False

        return True