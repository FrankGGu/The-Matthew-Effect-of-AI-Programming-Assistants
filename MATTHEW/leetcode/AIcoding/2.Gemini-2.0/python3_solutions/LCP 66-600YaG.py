from collections import defaultdict

class Solution:
    def minStands(self, events: list[str]) -> int:
        counts = defaultdict(int)
        for event in events:
            start = event[0]
            end = event[1]
            for char in start:
                counts[char] += 1
            for char in end:
                counts[char] += 1

        return len(counts)