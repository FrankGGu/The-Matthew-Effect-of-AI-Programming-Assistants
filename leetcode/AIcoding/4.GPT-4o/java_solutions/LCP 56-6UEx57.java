class Solution {
    public int minTransfers(int[][] transactions) {
        Map<Integer, Integer> balanceMap = new HashMap<>();

        for (int[] transaction : transactions) {
            balanceMap.put(transaction[0], balanceMap.getOrDefault(transaction[0], 0) - transaction[2]);
            balanceMap.put(transaction[1], balanceMap.getOrDefault(transaction[1], 0) + transaction[2]);
        }

        List<Integer> balances = new ArrayList<>();
        for (int balance : balanceMap.values()) {
            if (balance != 0) {
                balances.add(balance);
            }
        }

        return minTransfersHelper(balances, 0);
    }

    private int minTransfersHelper(List<Integer> balances, int start) {
        while (start < balances.size() && balances.get(start) == 0) {
            start++;
        }
        if (start == balances.size()) return 0;

        int minTransfers = Integer.MAX_VALUE;
        for (int i = start + 1; i < balances.size(); i++) {
            if (balances.get(i) * balances.get(start) < 0) {
                balances.set(i, balances.get(i) + balances.get(start));
                minTransfers = Math.min(minTransfers, 1 + minTransfersHelper(balances, start + 1));
                balances.set(i, balances.get(i) - balances.get(start));
            }
        }
        return minTransfers;
    }
}