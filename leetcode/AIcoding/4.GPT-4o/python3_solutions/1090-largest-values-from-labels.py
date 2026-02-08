class Solution:
    def largestValsFromLabels(self, values: List[int], labels: List[int], numWanted: int, useLimit: int) -> int:
        from collections import defaultdict

        label_count = defaultdict(int)
        indexed_values = sorted(zip(values, labels), reverse=True)
        total_value = 0
        count = 0

        for value, label in indexed_values:
            if count < numWanted:
                if label_count[label] < useLimit:
                    total_value += value
                    label_count[label] += 1
                    count += 1

        return total_value