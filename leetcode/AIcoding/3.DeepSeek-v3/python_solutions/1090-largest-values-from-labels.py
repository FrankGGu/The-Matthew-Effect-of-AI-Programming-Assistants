class Solution:
    def largestValsFromLabels(self, values: List[int], labels: List[int], num_wanted: int, use_limit: int) -> int:
        items = list(zip(values, labels))
        items.sort(reverse=True)

        label_count = {}
        total = 0
        selected = 0

        for value, label in items:
            if selected >= num_wanted:
                break
            if label_count.get(label, 0) < use_limit:
                total += value
                label_count[label] = label_count.get(label, 0) + 1
                selected += 1

        return total