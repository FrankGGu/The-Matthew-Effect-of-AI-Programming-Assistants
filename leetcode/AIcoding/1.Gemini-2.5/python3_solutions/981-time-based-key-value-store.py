import collections

class TimeMap:

    def __init__(self):
        self.store = collections.defaultdict(list)

    def set(self, key: str, value: str, timestamp: int) -> None:
        self.store[key].append((timestamp, value))

    def get(self, key: str, timestamp: int) -> str:
        if key not in self.store:
            return ""

        values = self.store[key]

        low = 0
        high = len(values) - 1
        ans_val = ""

        while low <= high:
            mid = (low + high) // 2
            if values[mid][0] <= timestamp:
                ans_val = values[mid][1]
                low = mid + 1
            else:
                high = mid - 1

        return ans_val