class Solution:
    def lengthLongestPath(self, input: str) -> int:
        stack = [0]
        max_len = 0
        for line in input.splitlines():
            name = line.lstrip('\t')
            depth = len(line) - len(name)
            while depth < len(stack) - 1:
                stack.pop()
            stack.append(stack[-1] + len(name) + 1)
            if '.' in name:
                max_len = max(max_len, stack[-1] - 1)
        return max_len