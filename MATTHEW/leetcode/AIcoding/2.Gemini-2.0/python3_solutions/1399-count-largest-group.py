class Solution:
    def countLargestGroup(self, n: int) -> int:
        counts = {}
        for i in range(1, n + 1):
            s = sum(map(int, str(i)))
            if s not in counts:
                counts[s] = 0
            counts[s] += 1

        max_count = 0
        for count in counts.values():
            max_count = max(max_count, count)

        result = 0
        for count in counts.values():
            if count == max_count:
                result += 1

        return result