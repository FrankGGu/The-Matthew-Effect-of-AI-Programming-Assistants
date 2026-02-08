import java.util.HashMap;
import java.util.Map;

class Cashier {
    private int n;
    private int discount;
    private Map<Integer, Integer> productPrices;
    private int customerCount;

    public Cashier(int n, int discount, int[] products, int[] prices) {
        this.n = n;
        this.discount = discount;
        this.productPrices = new HashMap<>();
        for (int i = 0; i < products.length; i++) {
            productPrices.put(products[i], prices[i]);
        }
        this.customerCount = 0;
    }

    public double getBill(int[] product, int[] amount) {
        customerCount++;
        double totalBill = 0.0;

        for (int i = 0; i < product.length; i++) {
            int productId = product[i];
            int quantity = amount[i];
            totalBill += productPrices.get(productId) * quantity;
        }

        if (customerCount % n == 0) {
            totalBill = totalBill * (100 - discount) / 100.0;
        }

        return totalBill;
    }
}