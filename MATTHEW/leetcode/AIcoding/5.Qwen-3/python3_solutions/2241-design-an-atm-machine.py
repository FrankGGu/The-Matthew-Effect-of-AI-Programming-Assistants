class ATM:
    def __init__(self):
        self.bills = [20, 50, 100, 200, 500]
        self.counts = [0, 0, 0, 0, 0]

    def deposit(self, banknotesCount: List[int]) -> None:
        for i in range(5):
            self.counts[i] += banknotesCount[i]

    def withdraw(self, amount: int) -> List[int]:
        res = [0, 0, 0, 0, 0]
        for i in range(4, -1, -1):
            if amount >= self.bills[i]:
                count = min(amount // self.bills[i], self.counts[i])
                res[i] = count
                amount -= count * self.bills[i]
        if amount == 0:
            for i in range(5):
                self.counts[i] -= res[i]
            return res
        else:
            return [-1]