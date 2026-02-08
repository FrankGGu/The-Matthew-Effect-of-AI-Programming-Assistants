import collections

class Solution:
    def removeInvalidParentheses(self, s: str) -> list[str]:

        def _is_valid(current_s: str) -> bool:
            count = 0
            for char in current_s:
                if char == '(':
                    count += 1
                elif char == ')':
                    count -= 1
                if count < 0:
                    return False
            return count == 0

        queue = collections.deque([s])
        visited = {s}
        result = []
        found_at_level = False

        while queue:
            current_level_size = len(queue)
            for _ in range(current_level_size):
                current_s = queue.popleft()

                if _is_valid(current_s):
                    result.append(current_s)
                    found_at_level = True

                if found_at_level:
                    continue

                for i in range(len(current_s)):
                    if current_s[i] == '(' or current_s[i] == ')':
                        next_s = current_s[:i] + current_s[i+1:]
                        if next_s not in visited:
                            visited.add(next_s)
                            queue.append(next_s)

            if found_at_level:
                break

        return result