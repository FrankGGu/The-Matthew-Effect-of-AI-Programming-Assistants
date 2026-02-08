class RangeFreqQuery:

    def __init__(self, arr: list[int]):
        self.arr = arr

    def query(self, left: int, right: int, value: int) -> int:
        count = 0
        for i in range(left, right + 1):
            if self.arr[i] == value:
                count += 1
        return count