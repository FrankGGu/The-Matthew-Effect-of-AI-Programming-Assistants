class Solution:
    def maximumGain(self, s: str, x: int, y: int) -> int:
        score = 0
        if x > y:
            pattern1, pattern2 = "ab", "ba"
            gain1, gain2 = x, y
        else:
            pattern1, pattern2 = "ba", "ab"
            gain1, gain2 = y, x

        stack = []
        for char in s:
            stack.append(char)
            while len(stack) >= 2 and stack[-2] + stack[-1] == pattern1:
                stack.pop()
                stack.pop()
                score += gain1

        temp_stack = []
        while stack:
            char = stack.pop()
            if temp_stack and temp_stack[-1] + char == pattern2[::-1]:
                temp_stack.pop()
                score += gain2
            else:
                temp_stack.append(char)

        return score