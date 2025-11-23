struct Bank {
    balances: Vec<i64>,
}

impl Bank {
    fn new(balance: Vec<i64>) -> Self {
        Bank {
            balances: balance,
        }
    }

    fn is_valid_account(&self, account: i32) -> bool {
        account > 0 && (account as usize) <= self.balances.len()
    }

    fn transfer(&mut self, account1: i32, account2: i32, amount: i64) -> bool {
        if !self.is_valid_account(account1) || !self.is_valid_account(account2) {
            return false;
        }

        let idx1 = (account1 - 1) as usize;
        let idx2 = (account2 - 1) as usize;

        if self.balances[idx1] < amount {
            return false;
        }

        self.balances[idx1] -= amount;
        self.balances[idx2] += amount;
        true
    }

    fn deposit(&mut self, account: i32, amount: i64) -> bool {
        if !self.is_valid_account(account) {
            return false;
        }

        let idx = (account - 1) as usize;
        self.balances[idx] += amount;
        true
    }

    fn withdraw(&mut self, account: i32, amount: i64) -> bool {
        if !self.is_valid_account(account) {
            return false;
        }

        let idx = (account - 1) as usize;

        if self.balances[idx] < amount {
            return false;
        }

        self.balances[idx] -= amount;
        true
    }
}