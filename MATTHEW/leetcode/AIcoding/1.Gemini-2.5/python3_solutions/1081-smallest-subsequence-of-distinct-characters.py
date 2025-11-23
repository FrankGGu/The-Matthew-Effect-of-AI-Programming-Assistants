import collections

class Solution:
    def smallestSubsequence(self, s: str) -> str:
        counts = collections.Counter(s)
        stack = []
        in_stack = set()

        for char in s:
            counts[char] -= 1

            if char in in_stack:
                continue

            while stack and char < stack[-1] and counts[stack[-1]] > 0:
                popped_char = stack.pop()
                in_stack.remove(popped_char)

            stack.append(char)
            in_stack.add(char)

        return "".join(stack)