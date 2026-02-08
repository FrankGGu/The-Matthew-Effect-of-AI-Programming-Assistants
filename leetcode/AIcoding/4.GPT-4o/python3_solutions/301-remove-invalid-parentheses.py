from collections import deque

def removeInvalidParentheses(s: str) -> List[str]:
    def is_valid(string):
        count = 0
        for char in string:
            if char == '(':
                count += 1
            elif char == ')':
                count -= 1
            if count < 0:
                return False
        return count == 0

    result = set()
    queue = deque([s])
    found = False

    while queue:
        current = queue.popleft()
        if is_valid(current):
            result.add(current)
            found = True
        if found:
            continue
        for i in range(len(current)):
            if current[i] not in ('(', ')'):
                continue
            next_state = current[:i] + current[i+1:]
            queue.append(next_state)

    return list(result)