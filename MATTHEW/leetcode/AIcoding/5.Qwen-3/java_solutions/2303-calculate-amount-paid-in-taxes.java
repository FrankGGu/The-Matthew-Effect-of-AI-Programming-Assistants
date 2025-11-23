public class Solution {
    public double calculateTax(double[] brackets, int income) {
        double tax = 0;
        int prev = 0;
        for (double[] bracket : brackets) {
            int level = (int) bracket[0];
            double percent = bracket[1];
            int diff = level - prev;
            if (income <= prev) {
                break;
            }
            tax += Math.min(income, prev + diff) * percent / 100;
            prev = level;
        }
        return tax;
    }
}