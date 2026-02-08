class Solution:
    def getHappyString(self, n: int, k: int) -> str:
        self.n = n
        self.k = k
        self.count = 0
        self.result = ""

        def backtrack(current_string: str):
            if self.result:  # If the k-th string is already found, stop further exploration
                return

            if len(current_string) == self.n:
                self.count += 1
                if self.count == self.k:
                    self.result = current_string
                return

            for char_code in range(ord('a'), ord('c') + 1):
                char = chr(char_code)
                if not current_string or char != current_string[-1]:
                    backtrack(current_string + char)
                    if self.result: # Propagate the found result up the call stack
                        return

        backtrack("")
        return self.result