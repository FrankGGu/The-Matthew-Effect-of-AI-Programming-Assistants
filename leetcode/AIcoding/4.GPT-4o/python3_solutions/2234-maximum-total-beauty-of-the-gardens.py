class Solution:
    def maximumBeauty(self, flowers: List[int], newFlowers: int, target: int) -> int:
        flowers.sort()
        n = len(flowers)
        prefix = [0] * (n + 1)

        for i in range(n):
            prefix[i + 1] = prefix[i] + flowers[i]

        max_beauty = 0

        for i in range(n + 1):
            current = flowers[i - 1] if i > 0 else 0
            needed = (i * target) - prefix[i]

            if needed <= newFlowers:
                max_beauty = max(max_beauty, target + (newFlowers - needed) // (n - i) if n > i else target)

        return max_beauty