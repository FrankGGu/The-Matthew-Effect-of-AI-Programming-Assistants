class Solution:
    def canSeePersonsCount(self, heights: List[int]) -> List[int]:
        result = []
        stack = []

        for height in heights:
            count = 0
            while stack and stack[-1] < height:
                stack.pop()
                count += 1
            if stack:
                count += 1
            result.append(count)
            stack.append(height)

        return result