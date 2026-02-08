class Solution:
    def splitArraySameAverage(self, A: List[int]) -> bool:
        n = len(A)
        total_sum = sum(A)
        A.sort()

        for size in range(1, n // 2 + 1):
            if total_sum * size % n != 0:
                continue
            target_sum = total_sum * size // n
            if self.can_partition(A, n, size, target_sum):
                return True
        return False

    def can_partition(self, A, n, size, target_sum):
        dp = [set() for _ in range(size + 1)]
        dp[0].add(0)

        for num in A:
            for s in range(size, 0, -1):
                for prev_sum in list(dp[s - 1]):
                    new_sum = prev_sum + num
                    if new_sum <= target_sum:
                        dp[s].add(new_sum)

        return target_sum in dp[size]