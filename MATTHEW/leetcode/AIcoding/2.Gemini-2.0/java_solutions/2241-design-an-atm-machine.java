class ATM {

    private long[] banknotes;
    private int[] denominations = {20, 50, 100, 200, 500};

    public ATM() {
        banknotes = new long[5];
    }

    public void deposit(int[] deposited) {
        for (int i = 0; i < 5; i++) {
            banknotes[i] += deposited[i];
        }
    }

    public int[] withdraw(int amount) {
        long[] withdrawn = new long[5];
        for (int i = 4; i >= 0; i--) {
            long count = Math.min(banknotes[i], amount / denominations[i]);
            withdrawn[i] = count;
            amount -= count * denominations[i];
        }

        if (amount != 0) {
            return new int[]{-1};
        }

        for (int i = 0; i < 5; i++) {
            banknotes[i] -= withdrawn[i];
        }

        int[] result = new int[5];
        for (int i = 0; i < 5; i++) {
            result[i] = (int) withdrawn[i];
        }
        return result;
    }
}