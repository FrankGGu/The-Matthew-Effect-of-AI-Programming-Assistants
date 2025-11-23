class Solution:
    def canArrange(self, arr: List[int], k: int) -> bool:
        remainder_counts = [0] * k
        for num in arr:
            remainder = num % k
            if remainder < 0:
                remainder += k
            remainder_counts[remainder] += 1

        if remainder_counts[0] % 2 != 0:
            return False

        for i in range(1, k // 2 + 1):
            if i != k - i and remainder_counts[i] != remainder_counts[k - i]:
                return False
            if i == k - i and remainder_counts[i] % 2 != 0:
                return False

        return True