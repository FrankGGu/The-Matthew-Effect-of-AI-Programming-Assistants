class Solution:
    def minRemoveToMakeValid(self, s: str) -> str:
        def remove(s, open_char, close_char):
            count = 0
            result = []
            for char in s:
                if char == open_char:
                    count += 1
                elif char == close_char:
                    if count == 0:
                        continue
                    count -= 1
                result.append(char)
            return ''.join(result)

        s = remove(s, '(', ')')
        s = remove(s[::-1], ')', '(')[::-1]
        return s