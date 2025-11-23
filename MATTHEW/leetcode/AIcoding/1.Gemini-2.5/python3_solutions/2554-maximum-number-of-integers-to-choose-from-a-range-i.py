class Solution:
    def maxCount(self, banned: list[int], n: int, maxSum: int) -> int:
        banned_set = set(banned)

        count = 0
        current_sum = 0

        for i in range(1, n + 1):
            if i in banned_set:
                continue

            if current_sum + i <= maxSum:
                current_sum += i
                count += 1
            else:
                # If adding the current smallest available number exceeds maxSum,
                # then adding any larger number will also exceed it.
                break

        return count