import collections

class FrequencyTracker:

    def __init__(self):
        self.number_counts = collections.defaultdict(int)
        self.frequency_counts = collections.defaultdict(int)

    def add(self, number: int) -> None:
        old_freq = self.number_counts[number]
        if old_freq > 0:
            self.frequency_counts[old_freq] -= 1

        self.number_counts[number] += 1
        new_freq = self.number_counts[number]
        self.frequency_counts[new_freq] += 1

    def deleteOne(self, number: int) -> None:
        current_freq = self.number_counts[number]

        if current_freq == 0:
            return

        self.frequency_counts[current_freq] -= 1
        self.number_counts[number] -= 1
        new_freq = self.number_counts[number]

        if new_freq > 0:
            self.frequency_counts[new_freq] += 1

    def hasFrequency(self, frequency: int) -> bool:
        return self.frequency_counts[frequency] > 0