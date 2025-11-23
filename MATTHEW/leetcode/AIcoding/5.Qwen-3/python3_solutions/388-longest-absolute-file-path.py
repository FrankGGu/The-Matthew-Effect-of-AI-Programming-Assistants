class Solution:
    def lengthLongestPath(self, input: str) -> int:
        lines = input.split('\n')
        stack = []
        max_length = 0
        for line in lines:
            name = line.lstrip('\t')
            depth = len(line) - len(name)
            while stack and stack[-1][1] >= depth:
                stack.pop()
            if '.' in name:
                current_length = (stack[-1][0] + len(name)) if stack else len(name)
                max_length = max(max_length, current_length)
            else:
                stack.append((len(name), depth))
        return max_length