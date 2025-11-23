class LUPrefix:

    def __init__(self, n: int):
        self.uploaded = [False] * (n + 1)
        self.longest_prefix_len = 0
        self.n = n

    def upload(self, video: int) -> None:
        self.uploaded[video] = True
        while self.longest_prefix_len + 1 <= self.n and self.uploaded[self.longest_prefix_len + 1]:
            self.longest_prefix_len += 1

    def longest(self) -> int:
        return self.longest_prefix_len