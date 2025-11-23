impl Solution {

use std::collections::HashMap;

struct Bank {
    balances: HashMap<i64, i64>,
}

impl Bank {
    fn new(balance: Vec<i64>) -> Self {
        let mut map = HashMap::new();
        for (i, &amount) in balance.iter().enumerate() {
            map.insert(i as i64, amount);
        }
        Bank { balances: map }
    }

    fn transfer(&mut self, account1: i64, account2: i64, money: i64) -> bool {
        if let Some(&balance) = self.balances.get(&account1) {
            if balance >= money {
                self.balances.insert(account1, balance - money);
                if let Some(&other_balance) = self.balances.get(&account2) {
                    self.balances.insert(account2, other_balance + money);
                    return true;
                }
            }
        }
        false
    }

    fn deposit(&mut self, account: i64, money: i64) -> bool {
        if let Some(balance) = self.balances.get_mut(&account) {
            *balance += money;
            true
        } else {
            false
        }
    }

    fn withdraw(&mut self, account: i64, money: i64) -> bool {
        if let Some(balance) = self.balances.get_mut(&account) {
            if *balance >= money {
                *balance -= money;
                true
            } else {
                false
            }
        } else {
            false
        }
    }
}
}