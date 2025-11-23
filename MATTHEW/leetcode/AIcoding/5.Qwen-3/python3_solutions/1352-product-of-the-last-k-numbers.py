class ProductOfTheLastKNumbers:
    def __init__(self, nums: List[int]):
        self.prefix = [1]
        for num in nums:
            self.prefix.append(self.prefix[-1] * num)

    def add(self, num: int) -> None:
        self.prefix.append(self.prefix[-1] * num)

    def getProduct(self, k: int) -> int:
        return self.prefix[-1] // self.prefix[-k - 1]