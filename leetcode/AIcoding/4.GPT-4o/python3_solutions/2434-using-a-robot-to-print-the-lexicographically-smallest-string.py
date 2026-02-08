class Solution:
    def robotWithString(self, s: str) -> str:
        from collections import Counter
        stack = []
        result = []
        counter = Counter(s)

        for char in s:
            stack.append(char)
            counter[char] -= 1

            while stack and (not counter or stack[-1] <= min(counter)):
                result.append(stack.pop())

        return ''.join(result)