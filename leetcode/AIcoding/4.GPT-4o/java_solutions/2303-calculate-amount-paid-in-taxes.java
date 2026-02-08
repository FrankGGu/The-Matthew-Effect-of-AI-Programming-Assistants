class Solution {
    public double calculateTax(int[][] brackets, int income) {
        double tax = 0.0;
        int prevLimit = 0;

        for (int[] bracket : brackets) {
            int limit = bracket[0];
            int rate = bracket[1];

            if (income > limit) {
                tax += (limit - prevLimit) * rate / 100.0;
                prevLimit = limit;
            } else {
                tax += (income - prevLimit) * rate / 100.0;
                break;
            }
        }

        return tax;
    }
}