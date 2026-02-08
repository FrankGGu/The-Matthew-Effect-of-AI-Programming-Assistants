class Solution:
    def smallestSubsequence(self, s: str, k: int, letter: str, repetition: int) -> str:
        stack = []
        count_letter = s.count(letter)

        for i, char in enumerate(s):
            while (stack and 
                   stack[-1] > char and 
                   len(stack) + len(s) - i - 1 >= k and 
                   (stack[-1] != letter or count_letter > repetition)):
                if stack[-1] == letter:
                    count_letter -= 1
                stack.pop()
            if len(stack) < k:
                if char == letter:
                    stack.append(char)
                    repetition -= 1
                elif k - len(stack) > repetition:
                    stack.append(char)

        return ''.join(stack[:k])