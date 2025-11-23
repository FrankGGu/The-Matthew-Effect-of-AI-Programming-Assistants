class Solution:
    def findLexSmallestString(self, s: str, a: int, b: int) -> str:
        visited = set()
        queue = [s]
        smallest = s
        while queue:
            current = queue.pop(0)
            if current < smallest:
                smallest = current
            # Add operation
            add_list = list(current)
            for i in range(1, len(add_list), 2):
                add_list[i] = str((int(add_list[i]) + a) % 10)
            add_str = ''.join(add_list)
            if add_str not in visited:
                visited.add(add_str)
                queue.append(add_str)
            # Rotate operation
            rotate_str = current[-b:] + current[:-b]
            if rotate_str not in visited:
                visited.add(rotate_str)
                queue.append(rotate_str)
        return smallest