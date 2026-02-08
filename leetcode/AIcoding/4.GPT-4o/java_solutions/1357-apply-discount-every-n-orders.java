class Cashier {
    private int n;
    private int discount;
    private int count;
    private double total;

    public Cashier(int n, int discount, int[] products, int[] prices) {
        this.n = n;
        this.discount = discount;
        this.count = 0;
        this.total = 0;
    }

    public double getBill(int[] product, int[] amount) {
        total = 0;
        for (int i = 0; i < product.length; i++) {
            total += prices[product[i] - 1] * amount[i];
        }
        count++;
        if (count == n) {
            total *= (100 - discount) / 100.0;
            count = 0;
        }
        return total;
    }
}