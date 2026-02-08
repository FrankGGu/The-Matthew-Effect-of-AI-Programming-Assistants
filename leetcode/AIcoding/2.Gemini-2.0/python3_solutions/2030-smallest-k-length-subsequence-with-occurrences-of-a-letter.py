class Solution:
    def smallestSubsequence(self, s: str, k: int, letter: str, repetition: int) -> str:
        n = len(s)
        rem = s.count(letter)
        stack = []
        for i, c in enumerate(s):
            while stack and s[i] < stack[-1] and n - i + len(stack) > k and (stack[-1] != letter or rem > repetition):
                if stack.pop() == letter:
                    repetition += 1

            if len(stack) < k:
                if s[i] == letter:
                    stack.append(s[i])
                    repetition -= 1
                elif k - len(stack) > repetition:
                    stack.append(s[i])

            if s[i] == letter:
                rem -= 1

        return "".join(stack)