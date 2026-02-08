class FrequencyTracker:

    def __init__(self):
        self.freq = defaultdict(int)
        self.freq_count = defaultdict(int)

    def add(self, number: int) -> None:
        if self.freq[number] > 0:
            self.freq_count[self.freq[number]] -= 1
        self.freq[number] += 1
        self.freq_count[self.freq[number]] += 1

    def deleteOne(self, number: int) -> None:
        if self.freq[number] > 0:
            self.freq_count[self.freq[number]] -= 1
            self.freq[number] -= 1
            if self.freq[number] > 0:
                self.freq_count[self.freq[number]] += 1

    def hasFrequency(self, frequency: int) -> bool:
        return self.freq_count[frequency] > 0