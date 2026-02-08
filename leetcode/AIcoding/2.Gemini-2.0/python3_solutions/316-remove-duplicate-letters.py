class Solution:
    def removeDuplicateLetters(self, s: str) -> str:
        last_occurrence = {}
        for i, char in enumerate(s):
            last_occurrence[char] = i

        stack = []
        visited = set()

        for i, char in enumerate(s):
            if char not in visited:
                while stack and char < stack[-1] and i < last_occurrence[stack[-1]]:
                    visited.remove(stack.pop())
                stack.append(char)
                visited.add(char)

        return "".join(stack)