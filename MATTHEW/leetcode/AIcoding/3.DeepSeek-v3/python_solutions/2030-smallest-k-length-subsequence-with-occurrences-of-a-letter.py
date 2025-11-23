class Solution:
    def smallestSubsequence(self, s: str, k: int, letter: str, repetition: int) -> str:
        stack = []
        n = len(s)
        count = s.count(letter)
        to_remove = n - k
        removed = 0

        for i, ch in enumerate(s):
            while stack and removed < to_remove and stack[-1] > ch:
                if stack[-1] == letter:
                    if count > repetition:
                        stack.pop()
                        removed += 1
                        count -= 1
                    else:
                        break
                else:
                    stack.pop()
                    removed += 1
            stack.append(ch)

        res = []
        have = 0
        for ch in stack:
            if ch == letter:
                have += 1

        to_add = max(0, repetition - have)
        to_remove = len(stack) - k

        for i in range(len(stack)-1, -1, -1):
            if to_remove <= 0:
                break
            if stack[i] != letter:
                stack.pop(i)
                to_remove -= 1

        for i in range(len(stack)-1, -1, -1):
            if to_add <= 0:
                break
            if stack[i] != letter:
                stack[i] = letter
                to_add -= 1

        return ''.join(stack[:k])