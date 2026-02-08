class Solution:
    def validateBookSequences(self, putIn: List[int], takeOut: List[int]) -> bool:
        stack = []
        i = 0
        for num in putIn:
            stack.append(num)
            while stack and stack[-1] == takeOut[i]:
                stack.pop()
                i += 1
        return not stack