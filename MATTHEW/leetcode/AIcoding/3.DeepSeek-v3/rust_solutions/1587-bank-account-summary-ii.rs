# Write your MySQL query statement below
# SELECT Users.name, SUM(Transactions.amount) AS balance
# FROM Users
# JOIN Transactions ON Users.account = Transactions.account
# GROUP BY Users.account
# HAVING balance > 10000
```

由于题目要求的是Rust解决方案，而LeetCode上的"Bank Account Summary II"是一个SQL题目，通常不需要Rust代码。不过，如果是在模拟数据库查询的Rust代码环境下，可以这样实现：

```rust
use std::collections::HashMap;

struct User {
    name: String,
    account: i32,
}

struct Transaction {
    account: i32,
    amount: i32,
}

impl Solution {
    pub fn bank_account_summary(users: Vec<User>, transactions: Vec<Transaction>) -> Vec<(String, i32)> {
        let mut balance_map: HashMap<i32, i32> = HashMap::new();

        for trans in transactions {
            *balance_map.entry(trans.account).or_insert(0) += trans.amount;
        }

        let mut result = Vec::new();
        for user in users {
            if let Some(&balance) = balance_map.get(&user.account) {
                if balance > 10000 {
                    result.push((user.name, balance));
                }
            }
        }

        result
    }
}