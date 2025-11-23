from collections import defaultdict
from typing import List

class Solution:
    def largestValues(self, labels: List[int], values: List[int], numWanted: int, useLimit: int) -> List[int]:
        label_counts = defaultdict(int)
        result = []
        items = sorted(zip(values, labels), reverse=True)

        for value, label in items:
            if label_counts[label] < useLimit:
                result.append(value)
                label_counts[label] += 1
                if len(result) == numWanted:
                    break

        return result