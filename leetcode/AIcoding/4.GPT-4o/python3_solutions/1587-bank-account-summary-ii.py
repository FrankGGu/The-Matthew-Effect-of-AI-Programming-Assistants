class Bank:
    def __init__(self, balance: List[int]):
        self.balance = balance

    def transfer(self, sender: int, receiver: int, amount: int) -> bool:
        if 1 <= sender <= len(self.balance) and 1 <= receiver <= len(self.balance):
            if self.balance[sender - 1] >= amount:
                self.balance[sender - 1] -= amount
                self.balance[receiver - 1] += amount
                return True
        return False

    def deposit(self, account: int, amount: int) -> bool:
        if 1 <= account <= len(self.balance):
            self.balance[account - 1] += amount
            return True
        return False

    def withdraw(self, account: int, amount: int) -> bool:
        if 1 <= account <= len(self.balance):
            if self.balance[account - 1] >= amount:
                self.balance[account - 1] -= amount
                return True
        return False