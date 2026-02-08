class Bank:

    def __init__(self, balance: List[int]):
        self.accounts = balance

    def transfer(self, sender: int, receiver: int, amount: int) -> bool:
        if 1 <= sender <= len(self.accounts) and 1 <= receiver <= len(self.accounts) and self.accounts[sender - 1] >= amount:
            self.accounts[sender - 1] -= amount
            self.accounts[receiver - 1] += amount
            return True
        return False

    def deposit(self, account: int, amount: int) -> bool:
        if 1 <= account <= len(self.accounts):
            self.accounts[account - 1] += amount
            return True
        return False

    def withdraw(self, account: int, amount: int) -> bool:
        if 1 <= account <= len(self.accounts) and self.accounts[account - 1] >= amount:
            self.accounts[account - 1] -= amount
            return True
        return False