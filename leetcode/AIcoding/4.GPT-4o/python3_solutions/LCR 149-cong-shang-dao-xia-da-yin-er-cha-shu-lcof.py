class Solution:
    def maximumBeauty(self, flowers: List[int], newFlowers: int, target: int) -> int:
        flowers.sort()
        n = len(flowers)
        left, right = 0, 0
        total_new = 0
        max_beauty = 0

        while right < n:
            while right < n and flowers[right] <= target:
                right += 1

            if right > 0:
                current_max = flowers[right-1]
                needed = (current_max + 1) * (right) - sum(flowers[:right])
                if needed <= newFlowers:
                    max_beauty = max(max_beauty, right)

            if right < n:
                needed = target * (right + 1) - sum(flowers[:right]) - flowers[right]
                if needed <= newFlowers:
                    max_beauty = max(max_beauty, right + 1)

            if left < right:
                total_new += flowers[left]
                left += 1
            else:
                right += 1

        return max_beauty