public class Solution {

import java.util.*;
import java.util.stream.Collectors;

public class Solution {
    public List<String> invalidTransactions = new ArrayList<>();

    public List<String> invalidTransactions(String[] transactions) {
        List<Transaction> list = new ArrayList<>();
        for (String t : transactions) {
            String[] parts = t.split(",");
            list.add(new Transaction(parts[0], Integer.parseInt(parts[1]), Integer.parseInt(parts[2]), parts[3]));
        }

        for (int i = 0; i < list.size(); i++) {
            Transaction t = list.get(i);
            if (t.amount > 1000) {
                invalidTransactions.add(t.original);
                continue;
            }
            boolean invalid = false;
            for (int j = 0; j < list.size(); j++) {
                if (i == j) continue;
                Transaction other = list.get(j);
                if (t.name.equals(other.name) && Math.abs(t.time - other.time) <= 60) {
                    invalid = true;
                    break;
                }
            }
            if (invalid) {
                invalidTransactions.add(t.original);
            }
        }

        return invalidTransactions;
    }

    private static class Transaction {
        String name;
        int time;
        int amount;
        String location;
        String original;

        public Transaction(String name, int time, int amount, String location) {
            this.name = name;
            this.time = time;
            this.amount = amount;
            this.location = location;
            this.original = name + "," + time + "," + amount + "," + location;
        }
    }
}
}