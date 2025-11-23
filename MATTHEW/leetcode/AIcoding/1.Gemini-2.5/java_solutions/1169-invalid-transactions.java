import java.util.ArrayList;
import java.util.List;

class Solution {

    class Transaction {
        String name;
        int time;
        int amount;
        String city;
        String originalString;
        int id;

        public Transaction(String transactionString, int id) {
            String[] parts = transactionString.split(",");
            this.name = parts[0];
            this.time = Integer.parseInt(parts[1]);
            this.amount = Integer.parseInt(parts[2]);
            this.city = parts[3];
            this.originalString = transactionString;
            this.id = id;
        }
    }

    public List<String> invalidTransactions(String[] transactions) {
        int n = transactions.length;
        Transaction[] parsedTransactions = new Transaction[n];
        boolean[] isInvalid = new boolean[n];

        for (int i = 0; i < n; i++) {
            parsedTransactions[i] = new Transaction(transactions[i], i);
            if (parsedTransactions[i].amount > 1000) {
                isInvalid[i] = true;
            }
        }

        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                Transaction t1 = parsedTransactions[i];
                Transaction t2 = parsedTransactions[j];

                if (t1.name.equals(t2.name) &&
                    !t1.city.equals(t2.city) &&
                    Math.abs(t1.time - t2.time) <= 60) {
                    isInvalid[i] = true;
                    isInvalid[j] = true;
                }
            }
        }

        List<String> result = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            if (isInvalid[i]) {
                result.add(parsedTransactions[i].originalString);
            }
        }

        return result;
    }
}