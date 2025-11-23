import java.util.*;

class Solution {
    public List<String> invalidTransactions(String[] transactions) {
        List<String> invalid = new ArrayList<>();
        Transaction[] trans = new Transaction[transactions.length];
        for (int i = 0; i < transactions.length; i++) {
            String[] t = transactions[i].split(",");
            trans[i] = new Transaction(t[0], Integer.parseInt(t[1]), Integer.parseInt(t[2]), t[3], transactions[i]);
        }

        for (int i = 0; i < trans.length; i++) {
            if (trans[i].amount > 1000) {
                invalid.add(trans[i].original);
                continue;
            }
            for (int j = i + 1; j < trans.length; j++) {
                if (trans[i].name.equals(trans[j].name) && !trans[i].city.equals(trans[j].city) && Math.abs(trans[i].time - trans[j].time) <= 60) {
                    if (!invalid.contains(trans[i].original)) {
                        invalid.add(trans[i].original);
                    }
                    if (!invalid.contains(trans[j].original)) {
                        invalid.add(trans[j].original);
                    }
                }
            }
        }

        return invalid;
    }

    class Transaction {
        String name;
        int time;
        int amount;
        String city;
        String original;

        public Transaction(String name, int time, int amount, String city, String original) {
            this.name = name;
            this.time = time;
            this.amount = amount;
            this.city = city;
            this.original = original;
        }
    }
}