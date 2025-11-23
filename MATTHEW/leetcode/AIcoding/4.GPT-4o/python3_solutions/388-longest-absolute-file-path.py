def lengthLongestPath(input: str) -> int:
    stack = []
    max_length = 0
    for line in input.splitlines():
        name = line.lstrip('\t')
        depth = line.count('\t')
        while len(stack) > depth:
            stack.pop()
        stack.append(name)
        if '.' in name:
            max_length = max(max_length, sum(len(x) + 1 for x in stack) - 1)
    return max_length