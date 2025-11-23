import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {
    public List<AccountSummaryResult> getAccountSummaries(List<User> users, List<Transaction> transactions) {
        Map<Integer, User> accountToUser = new HashMap<>();
        for (User user : users) {
            accountToUser.put(user.account, user);
        }

        Map<Integer, BigDecimal> accountBalances = new HashMap<>();
        for (User user : users) {
            accountBalances.put(user.account, BigDecimal.ZERO);
        }

        for (Transaction transaction : transactions) {
            accountBalances.merge(transaction.account, new BigDecimal(transaction.amount), BigDecimal::add);
        }

        List<AccountSummaryResult> summaries = new ArrayList<>();
        for (Map.Entry<Integer, BigDecimal> entry : accountBalances.entrySet()) {
            Integer account = entry.getKey();
            BigDecimal balance = entry.getValue();
            User user = accountToUser.get(account);

            if (user != null) {
                BigDecimal roundedBalance = balance.setScale(2, RoundingMode.HALF_UP);
                summaries.add(new AccountSummaryResult(user.name, roundedBalance.doubleValue()));
            }
        }
        return summaries;
    }

    public static class User {
        public int account;
        public String name;

        public User(int account, String name) {
            this.account = account;
            this.name = name;
        }
    }

    public static class Transaction {
        public int transId;
        public int account;
        public int amount;
        public String transDate;

        public Transaction(int transId, int account, int amount, String transDate) {
            this.transId = transId;
            this.account = account;
            this.amount = amount;
            this.transDate = transDate;
        }
    }

    public static class AccountSummaryResult {
        public String name;
        public double balance;

        public AccountSummaryResult(String name, double balance) {
            this.name = name;
            this.balance = balance;
        }
    }
}