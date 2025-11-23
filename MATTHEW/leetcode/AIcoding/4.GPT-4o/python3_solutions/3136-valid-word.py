class Solution:
    def isValid(self, word: str) -> bool:
        stack = []
        mapping = {')': '(', '}': '{', ']': '['}

        for char in word:
            if char in mapping.values():
                stack.append(char)
            elif char in mapping.keys():
                if stack == [] or mapping[char] != stack.pop():
                    return False
        return stack == []