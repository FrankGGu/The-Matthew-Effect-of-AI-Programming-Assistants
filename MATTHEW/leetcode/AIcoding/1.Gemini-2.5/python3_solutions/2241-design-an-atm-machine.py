from typing import List

class ATM:

    def __init__(self):
        self.banknote_values = [20, 50, 100, 200, 500]
        self.counts = [0] * 5

    def deposit(self, banknotesCount: List[int]) -> None:
        for i in range(5):
            self.counts[i] += banknotesCount[i]

    def withdraw(self, amount: int) -> List[int]:
        withdraw_counts = [0] * 5
        remaining_amount = amount

        for i in range(4, -1, -1):
            value = self.banknote_values[i]
            if remaining_amount >= value:
                num_to_take = min(self.counts[i], remaining_amount // value)
                withdraw_counts[i] = num_to_take
                remaining_amount -= num_to_take * value

        if remaining_amount == 0:
            for i in range(5):
                self.counts[i] -= withdraw_counts[i]
            return withdraw_counts
        else:
            return [-1]