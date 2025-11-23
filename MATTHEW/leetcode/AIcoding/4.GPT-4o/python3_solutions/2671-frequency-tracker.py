class FrequencyTracker:

    def __init__(self):
        self.num_count = {}
        self.freq_count = {}

    def add(self, number: int) -> None:
        if number in self.num_count:
            old_freq = self.num_count[number]
            self.num_count[number] += 1
            new_freq = old_freq + 1
            self.freq_count[old_freq] -= 1
            if self.freq_count[old_freq] == 0:
                del self.freq_count[old_freq]
            if new_freq in self.freq_count:
                self.freq_count[new_freq] += 1
            else:
                self.freq_count[new_freq] = 1
        else:
            self.num_count[number] = 1
            if 1 in self.freq_count:
                self.freq_count[1] += 1
            else:
                self.freq_count[1] = 1

    def deleteOne(self, number: int) -> None:
        if number in self.num_count and self.num_count[number] > 0:
            old_freq = self.num_count[number]
            self.num_count[number] -= 1
            new_freq = old_freq - 1
            self.freq_count[old_freq] -= 1
            if self.freq_count[old_freq] == 0:
                del self.freq_count[old_freq]
            if new_freq > 0:
                if new_freq in self.freq_count:
                    self.freq_count[new_freq] += 1
                else:
                    self.freq_count[new_freq] = 1

    def hasFrequency(self, frequency: int) -> bool:
        return frequency in self.freq_count and self.freq_count[frequency] > 0