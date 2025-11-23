class ATM {
    private long[] banknotes = new long[5];
    private final int[] denominations = {20, 50, 100, 200, 500};

    public ATM() {
    }

    public void deposit(int[] banknotesCount) {
        for (int i = 0; i < 5; i++) {
            banknotes[i] += banknotesCount[i];
        }
    }

    public int[] withdraw(int amount) {
        int[] result = new int[5];
        long[] temp = banknotes.clone();
        for (int i = 4; i >= 0; i--) {
            if (amount >= denominations[i]) {
                int count = Math.min((int) (amount / denominations[i]), (int) temp[i]);
                result[i] = count;
                amount -= count * denominations[i];
            }
        }
        if (amount > 0) {
            return new int[]{-1};
        }
        for (int i = 0; i < 5; i++) {
            banknotes[i] -= result[i];
        }
        return result;
    }

    public long[] getBanknotes() {
        return banknotes;
    }
}