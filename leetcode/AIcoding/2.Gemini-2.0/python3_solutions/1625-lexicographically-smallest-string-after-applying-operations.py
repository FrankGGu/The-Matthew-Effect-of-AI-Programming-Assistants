from collections import deque

class Solution:
    def findLexSmallestString(self, s: str, a: int, b: int) -> str:
        n = len(s)
        visited = set()
        q = deque([s])
        smallest = s

        while q:
            curr = q.popleft()
            if curr in visited:
                continue
            visited.add(curr)

            if curr < smallest:
                smallest = curr

            add_str = ""
            for i in range(n):
                if i % 2 == 1:
                    add_str += str((int(curr[i]) + a) % 10)
                else:
                    add_str += curr[i]

            add_str_list = list(add_str)

            add_str = "".join(add_str_list)

            rotate_str = curr[b:] + curr[:b]

            if add_str not in visited:
                q.append(add_str)
            if rotate_str not in visited:
                q.append(rotate_str)

        return smallest