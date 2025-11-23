class ATM {
    private long[] notes;
    private final int[] denominations = {20, 50, 100, 200, 500};

    public ATM() {
        notes = new long[5];
    }

    public void deposit(int[] banknotesCount) {
        for (int i = 0; i < 5; i++) {
            notes[i] += banknotesCount[i];
        }
    }

    public int[] withdraw(int amount) {
        int[] result = new int[5];
        long remaining = amount;

        for (int i = 4; i >= 0; i--) {
            if (remaining >= denominations[i] && notes[i] > 0) {
                long count = Math.min(remaining / denominations[i], notes[i]);
                remaining -= count * denominations[i];
                result[i] = (int) count;
            }
        }

        if (remaining != 0) {
            return new int[]{-1};
        }

        for (int i = 0; i < 5; i++) {
            notes[i] -= result[i];
        }

        return result;
    }
}