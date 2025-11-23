class Solution:
    def lexMinAfterRemoval(self, s: str, k: int) -> str:
        stack = []
        for char in s:
            while k > 0 and stack and stack[-1] > char:
                stack.pop()
                k -= 1
            stack.append(char)
        return ''.join(stack[:len(stack)-k])