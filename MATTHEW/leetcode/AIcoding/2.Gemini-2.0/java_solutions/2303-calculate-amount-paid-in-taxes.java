class Solution {
    public double calculateTax(int[][] brackets, int income) {
        double tax = 0.0;
        int prev = 0;
        for (int[] bracket : brackets) {
            int upper = bracket[0];
            int percent = bracket[1];
            int taxable = Math.min(income, upper - prev);
            if (taxable > 0) {
                tax += (double) taxable * percent / 100;
                income -= taxable;
            }
            if (income <= 0) {
                break;
            }
            prev = upper;
        }
        return tax;
    }
}