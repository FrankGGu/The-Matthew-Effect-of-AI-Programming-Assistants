class FreqStack:

    def __init__(self):
        self.freq = {}
        self.group = []
        self.max_freq = 0

    def push(self, x: int) -> None:
        if x in self.freq:
            self.freq[x] += 1
        else:
            self.freq[x] = 1
        f = self.freq[x]
        if f > self.max_freq:
            self.max_freq = f
            self.group.append([])
        self.group[f - 1].append(x)

    def pop(self) -> int:
        x = self.group[self.max_freq - 1].pop()
        self.freq[x] -= 1
        if not self.group[self.max_freq - 1]:
            self.max_freq -= 1
        return x