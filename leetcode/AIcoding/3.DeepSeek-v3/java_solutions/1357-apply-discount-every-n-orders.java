class Cashier {
    private int n;
    private int discount;
    private int[] products;
    private int[] prices;
    private int count;

    public Cashier(int n, int discount, int[] products, int[] prices) {
        this.n = n;
        this.discount = discount;
        this.products = products;
        this.prices = prices;
        this.count = 0;
    }

    public double getBill(int[] product, int[] amount) {
        count++;
        double total = 0;
        for (int i = 0; i < product.length; i++) {
            int index = findIndex(product[i]);
            total += prices[index] * amount[i];
        }
        if (count % n == 0) {
            total = total * (100 - discount) / 100;
        }
        return total;
    }

    private int findIndex(int product) {
        for (int i = 0; i < products.length; i++) {
            if (products[i] == product) {
                return i;
            }
        }
        return -1;
    }
}