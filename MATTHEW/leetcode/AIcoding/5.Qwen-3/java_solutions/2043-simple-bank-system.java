public class Solution {

import java.util.HashMap;
import java.util.Map;

public class Bank {
    private Map<Integer, Long> accounts;

    public Bank(long[] balance) {
        accounts = new HashMap<>();
        for (int i = 0; i < balance.length; i++) {
            accounts.put(i + 1, balance[i]);
        }
    }

    public boolean transfer(int account1, int account2, long money) {
        if (!accounts.containsKey(account1) || !accounts.containsKey(account2)) {
            return false;
        }
        if (accounts.get(account1) < money) {
            return false;
        }
        accounts.put(account1, accounts.get(account1) - money);
        accounts.put(account2, accounts.get(account2) + money);
        return true;
    }

    public boolean deposit(int account, long money) {
        if (!accounts.containsKey(account)) {
            return false;
        }
        accounts.put(account, accounts.get(account) + money);
        return true;
    }

    public boolean withdraw(int account, long money) {
        if (!accounts.containsKey(account) || accounts.get(account) < money) {
            return false;
        }
        accounts.put(account, accounts.get(account) - money);
        return true;
    }
}
}