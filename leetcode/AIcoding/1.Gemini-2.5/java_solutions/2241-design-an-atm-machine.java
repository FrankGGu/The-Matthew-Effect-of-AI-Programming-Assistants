class ATM {

    private long[] counts; 
    private final long[] denominations; 

    public ATM() {
        counts = new long[5];
        denominations = new long[]{20, 50, 100, 200, 500};
    }

    public void deposit(int[] banknotesCount) {
        for (int i = 0; i < 5; i++) {
            counts[i] += banknotesCount[i];
        }
    }

    public int[] withdraw(int amount) {
        long[] tempCounts = new long[5]; 
        System.arraycopy(counts, 0, tempCounts, 0, 5);

        long[] withdrawnBanknotes = new long[5]; 
        long remainingAmount = amount;

        for (int i = 4; i >= 0; i--) {
            long denom = denominations[i];
            if (remainingAmount >= denom) {
                long numToWithdraw = Math.min(remainingAmount / denom, tempCounts[i]);

                remainingAmount -= numToWithdraw * denom;
                withdrawnBanknotes[i] = numToWithdraw;
            }
        }

        if (remainingAmount == 0) {
            for (int i = 0; i < 5; i++) {
                counts[i] -= withdrawnBanknotes[i];
            }
            int[] result = new int[5];
            for (int i = 0; i < 5; i++) {
                result[i] = (int) withdrawnBanknotes[i];
            }
            return result;
        } else {
            return new int[]{-1};
        }
    }
}