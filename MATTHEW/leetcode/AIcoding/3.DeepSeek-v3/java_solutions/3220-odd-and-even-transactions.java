import java.util.*;

class Solution {
    public List<String> invalidTransactions(String[] transactions) {
        Map<String, List<Transaction>> map = new HashMap<>();
        Set<String> invalid = new HashSet<>();

        for (String t : transactions) {
            Transaction trans = new Transaction(t);
            map.putIfAbsent(trans.name, new ArrayList<>());
            map.get(trans.name).add(trans);
        }

        for (String name : map.keySet()) {
            List<Transaction> list = map.get(name);
            for (int i = 0; i < list.size(); i++) {
                Transaction curr = list.get(i);
                if (curr.amount > 1000) {
                    invalid.add(curr.original);
                } else {
                    for (int j = 0; j < list.size(); j++) {
                        if (i == j) continue;
                        Transaction other = list.get(j);
                        if (!curr.city.equals(other.city) && Math.abs(curr.time - other.time) <= 60) {
                            invalid.add(curr.original);
                            break;
                        }
                    }
                }
            }
        }

        return new ArrayList<>(invalid);
    }

    class Transaction {
        String name;
        int time;
        int amount;
        String city;
        String original;

        public Transaction(String t) {
            original = t;
            String[] parts = t.split(",");
            name = parts[0];
            time = Integer.parseInt(parts[1]);
            amount = Integer.parseInt(parts[2]);
            city = parts[3];
        }
    }
}