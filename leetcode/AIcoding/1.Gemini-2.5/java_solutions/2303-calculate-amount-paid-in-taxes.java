class Solution {
    public double calculateTax(int[][] brackets, int income) {
        double totalTax = 0.0;
        int prevUpper = 0;

        for (int[] bracket : brackets) {
            int currentUpper = bracket[0];
            int percent = bracket[1];

            if (income <= prevUpper) {
                break;
            }

            int taxableAmountInThisBracket = Math.min(income, currentUpper) - prevUpper;

            totalTax += taxableAmountInThisBracket * (percent / 100.0);

            prevUpper = currentUpper;

            if (income <= currentUpper) {
                break;
            }
        }

        return totalTax;
    }
}