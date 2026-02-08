class Solution {
    public double calculateTax(int[][] brackets, int income) {
        double tax = 0;
        int prev = 0;
        for (int[] bracket : brackets) {
            int upper = bracket[0];
            int percent = bracket[1];
            if (income <= prev) {
                break;
            }
            int taxable = Math.min(upper, income) - prev;
            tax += taxable * percent / 100.0;
            prev = upper;
        }
        return tax;
    }
}