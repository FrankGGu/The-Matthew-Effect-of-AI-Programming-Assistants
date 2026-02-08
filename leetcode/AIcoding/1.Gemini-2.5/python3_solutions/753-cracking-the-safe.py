class Solution:
    def crackSafe(self, n: int, k: int) -> str:
        self.ans = []
        self.visited = set()
        self.k = k
        self.n = n

        start_node = "0" * (n - 1)

        self._dfs(start_node)

        return start_node + "".join(self.ans)

    def _dfs(self, node_prefix: str):
        for digit in range(self.k - 1, -1, -1):
            current_digit_char = str(digit)

            new_password = node_prefix + current_digit_char

            if new_password not in self.visited:
                self.visited.add(new_password)
                self.ans.append(current_digit_char)
                self._dfs(new_password[1:])