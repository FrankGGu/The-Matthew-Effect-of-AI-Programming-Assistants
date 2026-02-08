struct Bank {
    balance: Vec<i64>,
}

impl Bank {
    fn new(balance: Vec<i64>) -> Self {
        Bank { balance }
    }

    fn transfer(&mut self, account1: i32, account2: i32, money: i64) -> bool {
        let n = self.balance.len() as i32;
        if account1 < 1 || account1 > n || account2 < 1 || account2 > n {
            return false;
        }
        let idx1 = (account1 - 1) as usize;
        let idx2 = (account2 - 1) as usize;
        if self.balance[idx1] < money {
            return false;
        }
        self.balance[idx1] -= money;
        self.balance[idx2] += money;
        true
    }

    fn deposit(&mut self, account: i32, money: i64) -> bool {
        let n = self.balance.len() as i32;
        if account < 1 || account > n {
            return false;
        }
        let idx = (account - 1) as usize;
        self.balance[idx] += money;
        true
    }

    fn withdraw(&mut self, account: i32, money: i64) -> bool {
        let n = self.balance.len() as i32;
        if account < 1 || account > n {
            return false;
        }
        let idx = (account - 1) as usize;
        if self.balance[idx] < money {
            return false;
        }
        self.balance[idx] -= money;
        true
    }
}