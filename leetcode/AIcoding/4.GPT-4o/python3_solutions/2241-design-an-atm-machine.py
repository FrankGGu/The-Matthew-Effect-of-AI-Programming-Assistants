class ATM:
    def __init__(self):
        self.bills = [20, 50, 100, 200, 500]
        self.counts = [0] * 5

    def deposit(self, banknotesCount: List[int]) -> None:
        for i in range(5):
            self.counts[i] += banknotesCount[i]

    def withdraw(self, amount: int) -> List[int]:
        result = [0] * 5
        for i in range(4, -1, -1):
            if amount == 0:
                break
            take = min(amount // self.bills[i], self.counts[i])
            result[i] = take
            amount -= take * self.bills[i]

        if amount > 0:
            return [-1]

        for i in range(5):
            self.counts[i] -= result[i]

        return result