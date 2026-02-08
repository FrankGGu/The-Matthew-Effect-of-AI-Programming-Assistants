struct Bank {
    balance: Vec<i64>,
}

impl Bank {
    fn new(balance: Vec<i64>) -> Self {
        Bank { balance }
    }

    fn transfer(&mut self, sender: i32, receiver: i32, amount: i64) -> bool {
        if sender < 1 || sender > self.balance.len() as i32 || receiver < 1 || receiver > self.balance.len() as i32 {
            return false;
        }
        if self.balance[sender as usize - 1] < amount {
            return false;
        }
        self.balance[sender as usize - 1] -= amount;
        self.balance[receiver as usize - 1] += amount;
        true
    }

    fn deposit(&mut self, account: i32, amount: i64) -> bool {
        if account < 1 || account > self.balance.len() as i32 {
            return false;
        }
        self.balance[account as usize - 1] += amount;
        true
    }

    fn withdraw(&mut self, account: i32, amount: i64) -> bool {
        if account < 1 || account > self.balance.len() as i32 {
            return false;
        }
        if self.balance[account as usize - 1] < amount {
            return false;
        }
        self.balance[account as usize - 1] -= amount;
        true
    }
}