class Bank:

    def __init__(self, balance: list[int]):
        self.balances = balance
        self.n = len(balance)

    def _is_valid_account(self, account: int) -> bool:
        return 1 <= account <= self.n

    def transfer(self, account1: int, account2: int, amount: int) -> bool:
        if not self._is_valid_account(account1) or not self._is_valid_account(account2):
            return False

        if self.balances[account1 - 1] < amount:
            return False

        self.balances[account1 - 1] -= amount
        self.balances[account2 - 1] += amount
        return True

    def deposit(self, account: int, amount: int) -> bool:
        if not self._is_valid_account(account):
            return False

        self.balances[account - 1] += amount
        return True

    def withdraw(self, account: int, amount: int) -> bool:
        if not self._is_valid_account(account):
            return False

        if self.balances[account - 1] < amount:
            return False

        self.balances[account - 1] -= amount
        return True