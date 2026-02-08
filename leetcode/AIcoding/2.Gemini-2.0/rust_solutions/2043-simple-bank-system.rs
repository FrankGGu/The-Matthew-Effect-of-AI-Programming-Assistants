struct Bank {
    balance: Vec<i64>,
}

impl Bank {
    fn new(balance: Vec<i64>) -> Self {
        Bank { balance }
    }

    fn transfer(&mut self, account1: i32, account2: i32, money: i64) -> bool {
        let n = self.balance.len();
        if account1 as usize > n || account2 as usize > n {
            return false;
        }
        if self.balance[account1 as usize - 1] < money {
            return false;
        }
        self.balance[account1 as usize - 1] -= money;
        self.balance[account2 as usize - 1] += money;
        true
    }

    fn deposit(&mut self, account: i32, money: i64) -> bool {
        let n = self.balance.len();
        if account as usize > n {
            return false;
        }
        self.balance[account as usize - 1] += money;
        true
    }

    fn withdraw(&mut self, account: i32, money: i64) -> bool {
        let n = self.balance.len();
        if account as usize > n {
            return false;
        }
        if self.balance[account as usize - 1] < money {
            return false;
        }
        self.balance[account as usize - 1] -= money;
        true
    }
}