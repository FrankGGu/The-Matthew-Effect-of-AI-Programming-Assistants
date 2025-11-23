class Solution:
    def numberOfVisiblePeople(self, h: List[int]) -> int:
        stack = []
        result = 0
        for height in h:
            count = 0
            while stack and stack[-1] < height:
                count += 1
                stack.pop()
            if stack:
                count += 1
            result += count
            stack.append(height)
        return result