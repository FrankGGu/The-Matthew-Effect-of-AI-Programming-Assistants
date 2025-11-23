class NeighborSumService:

    def __init__(self, arr: List[int]):
        self.arr = arr
        self.n = len(arr)
        self.prefix_sum = [0] * (self.n + 1)
        for i in range(self.n):
            self.prefix_sum[i + 1] = self.prefix_sum[i] + arr[i]

    def sum(self, left: int, right: int) -> int:
        if left == 0:
            return self.prefix_sum[right + 1]
        return self.prefix_sum[right + 1] - self.prefix_sum[left]

    def update(self, index: int, value: int) -> None:
        diff = value - self.arr[index]
        self.arr[index] = value
        for i in range(index + 1, self.n + 1):
            self.prefix_sum[i] += diff