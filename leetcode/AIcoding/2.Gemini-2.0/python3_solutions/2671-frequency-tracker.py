class FrequencyTracker:

    def __init__(self):
        self.nums = {}
        self.freq = {}

    def add(self, number: int) -> None:
        if number in self.nums:
            old_freq = self.nums[number]
            self.freq[old_freq] -= 1
            if self.freq[old_freq] == 0:
                del self.freq[old_freq]
            self.nums[number] += 1
            new_freq = self.nums[number]
            self.freq[new_freq] = self.freq.get(new_freq, 0) + 1
        else:
            self.nums[number] = 1
            self.freq[1] = self.freq.get(1, 0) + 1

    def deleteOne(self, number: int) -> None:
        if number in self.nums:
            old_freq = self.nums[number]
            if old_freq == 1:
                del self.nums[number]
                self.freq[1] -= 1
                if self.freq[1] == 0:
                    del self.freq[1]
            else:
                self.freq[old_freq] -= 1
                if self.freq[old_freq] == 0:
                    del self.freq[old_freq]
                self.nums[number] -= 1
                new_freq = self.nums[number]
                self.freq[new_freq] = self.freq.get(new_freq, 0) + 1

    def hasFrequency(self, frequency: int) -> bool:
        return frequency in self.freq