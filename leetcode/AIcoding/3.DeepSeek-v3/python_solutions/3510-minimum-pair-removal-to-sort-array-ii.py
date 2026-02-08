class Solution:
    def minDeletions(self, nums: List[int]) -> int:
        stack = []
        deletions = 0

        for num in nums:
            while stack and stack[-1] > num:
                stack.pop()
                deletions += 1
            stack.append(num)

        return deletions