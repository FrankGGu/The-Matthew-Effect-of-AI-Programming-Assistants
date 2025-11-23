class Cashier {
    private int n;
    private int discount;
    private int count;
    private double total;
    private double[] prices;

    public Cashier(int n, int discount, int[] products, int[] prices) {
        this.n = n;
        this.discount = discount;
        this.prices = new double[products.length];
        for (int i = 0; i < products.length; i++) {
            this.prices[products[i]] = prices[i];
        }
        this.count = 0;
    }

    public double getBill(int[] product, int[] quantity) {
        total = 0;
        for (int i = 0; i < product.length; i++) {
            total += prices[product[i]] * quantity[i];
        }
        count++;
        if (count % n == 0) {
            total *= (100 - discount) / 100.0;
        }
        return total;
    }
}