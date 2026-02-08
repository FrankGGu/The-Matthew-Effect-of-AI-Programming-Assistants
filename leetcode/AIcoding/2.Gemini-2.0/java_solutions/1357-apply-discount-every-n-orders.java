class Cashier {

    private int n;
    private int discount;
    private Map<Integer, Integer> priceMap;
    private int customerCount;

    public Cashier(int n, int discount, int[] products, int[] prices) {
        this.n = n;
        this.discount = discount;
        this.priceMap = new HashMap<>();
        for (int i = 0; i < products.length; i++) {
            priceMap.put(products[i], prices[i]);
        }
        this.customerCount = 0;
    }

    public double getBill(int[] product, int[] amount) {
        customerCount++;
        double total = 0;
        for (int i = 0; i < product.length; i++) {
            total += priceMap.get(product[i]) * amount[i];
        }
        if (customerCount % n == 0) {
            total = total * (100 - discount) / 100;
        }
        return total;
    }
}