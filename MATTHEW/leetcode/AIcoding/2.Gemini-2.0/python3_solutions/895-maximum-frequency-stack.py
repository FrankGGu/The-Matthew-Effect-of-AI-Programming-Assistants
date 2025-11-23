class FreqStack:

    def __init__(self):
        self.freq = {}
        self.group = {}
        self.maxfreq = 0

    def push(self, val: int) -> None:
        self.freq[val] = self.freq.get(val, 0) + 1
        self.maxfreq = max(self.maxfreq, self.freq[val])
        if self.freq[val] not in self.group:
            self.group[self.freq[val]] = []
        self.group[self.freq[val]].append(val)

    def pop(self) -> int:
        val = self.group[self.maxfreq].pop()
        self.freq[val] -= 1
        if not self.group[self.maxfreq]:
            self.maxfreq -= 1
        return val