import collections

class Solution:
    def largestValsFromLabels(self, values: list[int], labels: list[int], numWanted: int, useLimit: int) -> int:
        items = []
        for i in range(len(values)):
            items.append((values[i], labels[i]))

        items.sort(key=lambda x: x[0], reverse=True)

        total_sum = 0
        selected_count = 0
        label_counts = collections.defaultdict(int)

        for value, label in items:
            if selected_count < numWanted and label_counts[label] < useLimit:
                total_sum += value
                label_counts[label] += 1
                selected_count += 1

            if selected_count == numWanted:
                break

        return total_sum