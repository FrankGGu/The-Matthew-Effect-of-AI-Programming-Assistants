class Solution:
    def mostCompetitive(self, nums: list[int], k: int) -> list[int]:
        stack = []
        n = len(nums)

        for i, num in enumerate(nums):
            # While the stack is not empty, the current number `num` is smaller than the top of the stack,
            # AND there are enough remaining elements (including `num` itself) to form a subsequence of length `k`
            # even after popping the current stack top.
            # The condition `len(stack) - 1 + (n - i) >= k` ensures that after popping `stack[-1]`,
            # the remaining elements in the stack (`len(stack) - 1`) plus the elements yet to be processed
            # from `nums` (`n - i`, which includes the current `num` and all subsequent elements)
            # are still sufficient to reach the target length `k`.
            while stack and stack[-1] > num and len(stack) - 1 + (n - i) >= k:
                stack.pop()

            # If the stack has fewer than `k` elements, append the current number.
            # If the stack already has `k` elements, we only append if a pop operation occurred
            # (which would have reduced its size to `k-1`).
            if len(stack) < k:
                stack.append(num)

        return stack