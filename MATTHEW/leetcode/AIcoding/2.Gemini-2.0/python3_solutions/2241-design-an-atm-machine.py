class ATM:

    def __init__(self):
        self.banknotes = [0] * 5
        self.values = [20, 50, 100, 200, 500]

    def deposit(self, banknotesCount: List[int]) -> None:
        for i in range(5):
            self.banknotes[i] += banknotesCount[i]

    def withdraw(self, amount: int) -> List[int]:
        result = [0] * 5
        temp_banknotes = self.banknotes[:]
        for i in range(4, -1, -1):
            count = min(temp_banknotes[i], amount // self.values[i])
            result[i] = count
            amount -= count * self.values[i]
            temp_banknotes[i] -= count

        if amount == 0:
            self.banknotes = temp_banknotes
            return result
        else:
            return [-1]