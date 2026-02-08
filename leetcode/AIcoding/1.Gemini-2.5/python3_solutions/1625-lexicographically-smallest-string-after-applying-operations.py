import collections

class Solution:
    def findLexSmallestString(self, s: str, a: int, b: int) -> str:
        n = len(s)

        min_s = s

        queue = collections.deque([s])
        visited = {s}

        while queue:
            current_s = queue.popleft()

            # Update min_s if a lexicographically smaller string is found
            if current_s < min_s:
                min_s = current_s

            # Operation 1: Add 'a' to all odd-indexed digits
            s_list = list(current_s)
            for i in range(1, n, 2): # Iterate over odd indices (1-based)
                s_list[i] = str((int(s_list[i]) + a) % 10)
            next_s_add = "".join(s_list)

            if next_s_add not in visited:
                visited.add(next_s_add)
                queue.append(next_s_add)

            # Operation 2: Rotate the string by 'b' positions
            next_s_rotate = current_s[b:] + current_s[:b]

            if next_s_rotate not in visited:
                visited.add(next_s_rotate)
                queue.append(next_s_rotate)

        return min_s