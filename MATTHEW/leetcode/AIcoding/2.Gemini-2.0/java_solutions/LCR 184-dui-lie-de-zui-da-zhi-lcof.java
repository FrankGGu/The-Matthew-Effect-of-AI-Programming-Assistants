import java.util.HashMap;
import java.util.Map;

class CheckoutSystem {

    private Map<Integer, Integer> prices;
    private Map<Integer, Integer> counts;

    public CheckoutSystem(int[] price, int[] product) {
        prices = new HashMap<>();
        counts = new HashMap<>();
        for (int i = 0; i < product.length; i++) {
            prices.put(product[i], price[i]);
        }
    }

    public void addProduct(int id, int count) {
        counts.put(id, counts.getOrDefault(id, 0) + count);
    }

    public double calculateTotal() {
        double total = 0.0;
        for (Map.Entry<Integer, Integer> entry : counts.entrySet()) {
            int id = entry.getKey();
            int count = entry.getValue();
            if (prices.containsKey(id)) {
                total += (double) prices.get(id) * count;
            }
        }
        return total;
    }

    public void reset() {
        counts.clear();
    }
}