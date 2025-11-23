class Solution {
    public int totalMoney(int n) {
        int total = 0;
        int numWeeks = n / 7;
        int remainingDays = n % 7;

        // Calculate money for full weeks
        for (int i = 0; i < numWeeks; i++) {
            // For the (i+1)-th week (0-indexed i)
            // Money saved starts at (1 + i) on Monday and increments daily
            // Sum for this week: (1+i) + (2+i) + ... + (7+i)
            // This simplifies to (1+2+...+7) + 7*i = 28 + 7*i
            total += (28 + 7 * i);
        }

        // Calculate money for the remaining days
        // These days are in the (numWeeks + 1)-th week
        // On the j-th day (1-indexed) of this week, money saved is (numWeeks + j)
        for (int j = 1; j <= remainingDays; j++) {
            total += (numWeeks + j);
        }

        return total;
    }
}