class ATM:

    def __init__(self):
        self.notes = [0, 0, 0, 0, 0]
        self.values = [20, 50, 100, 200, 500]

    def deposit(self, banknotesCount: List[int]) -> None:
        for i in range(5):
            self.notes[i] += banknotesCount[i]

    def withdraw(self, amount: int) -> List[int]:
        res = [0] * 5
        remaining = amount
        for i in range(4, -1, -1):
            if remaining == 0:
                break
            if self.notes[i] == 0 or self.values[i] > remaining:
                continue
            cnt = min(remaining // self.values[i], self.notes[i])
            res[i] = cnt
            remaining -= cnt * self.values[i]
        if remaining != 0:
            return [-1]
        for i in range(5):
            self.notes[i] -= res[i]
        return res