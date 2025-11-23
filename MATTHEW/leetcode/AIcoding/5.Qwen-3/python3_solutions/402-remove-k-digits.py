class Solution:
    def removeKDigits(self, num: str, k: int) -> str:
        stack = []
        for digit in num:
            while k > 0 and stack and stack[-1] > digit:
                stack.pop()
                k -= 1
            stack.append(digit)
        if k > 0:
            stack = stack[:-k]
        return ''.join(stack).lstrip('0') or '0'