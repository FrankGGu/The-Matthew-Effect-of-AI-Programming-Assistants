class Solution:
    def largestValuesFromLabels(self, values: List[int], labels: List[int], num_wanted: int, use_limit: int) -> int:
        items = sorted(zip(values, labels), reverse=True)
        label_counts = {}
        result = 0
        count = 0
        for value, label in items:
            if label not in label_counts:
                label_counts[label] = 0
            if label_counts[label] < use_limit:
                result += value
                label_counts[label] += 1
                count += 1
            if count == num_wanted:
                break
        return result