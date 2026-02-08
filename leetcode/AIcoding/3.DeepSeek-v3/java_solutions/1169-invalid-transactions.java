class Solution {
    public List<String> invalidTransactions(String[] transactions) {
        List<String> invalid = new ArrayList<>();
        Map<String, List<Transaction>> map = new HashMap<>();

        for (String t : transactions) {
            Transaction trans = new Transaction(t);
            map.putIfAbsent(trans.name, new ArrayList<>());
            map.get(trans.name).add(trans);
        }

        for (String t : transactions) {
            Transaction trans = new Transaction(t);
            if (!isValid(trans, map.get(trans.name))) {
                invalid.add(t);
            }
        }

        return invalid;
    }

    private boolean isValid(Transaction trans, List<Transaction> list) {
        if (trans.amount > 1000) {
            return false;
        }
        for (Transaction t : list) {
            if (!t.city.equals(trans.city) && Math.abs(t.time - trans.time) <= 60) && !t.equals(trans)) {
                return false;
            }
        }
        return true;
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

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (o == null || getClass() != o.getClass()) return false;
            Transaction that = (Transaction) o;
            return original.equals(that.original);
        }

        @Override
        public int hashCode() {
            return original.hashCode();
        }
    }
}