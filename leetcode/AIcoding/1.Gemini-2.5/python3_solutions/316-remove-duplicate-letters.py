class Solution:
    def removeDuplicateLetters(self, s: str) -> str:

        stack = []
        seen = set()
        last_occurrence = {}
        for i, char in enumerate(s):
            last_occurrence[char] = i

        for i, char in enumerate(s):
            if char in seen:
                continue

            while stack and char < stack[-1] and i < last_occurrence[stack[-1]]:
                popped_char = stack.pop()
                seen.remove(popped_char)

            stack.append(char)
            seen.add(char)

        return "".join(stack)