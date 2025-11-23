class FrequencyTracker:
    def __init__(self):
        self.count = {}
        self.freq = {}

    def add(self, number: int) -> None:
        if number in self.count:
            self.freq[self.count[number]] -= 1
            if self.freq[self.count[number]] == 0:
                del self.freq[self.count[number]]
            self.count[number] += 1
        else:
            self.count[number] = 1
        self.freq[self.count[number]] = self.freq.get(self.count[number], 0) + 1

    def delete(self, number: int) -> None:
        if number in self.count:
            self.freq[self.count[number]] -= 1
            if self.freq[self.count[number]] == 0:
                del self.freq[self.count[number]]
            self.count[number] -= 1
            if self.count[number] == 0:
                del self.count[number]
            else:
                self.freq[self.count[number]] = self.freq.get(self.count[number], 0) + 1

    def hasFrequency(self, frequency: int) -> bool:
        return frequency in self.freq