import java.util.HashMap;
import java.util.Map;

class SelfCheckoutSystem {
    private Map<String, Double> productPrices;
    private Map<String, Integer> currentCart;
    private double currentDiscountPercentage;

    public SelfCheckoutSystem() {
        productPrices = new HashMap<>();
        currentCart = new HashMap<>();
        currentDiscountPercentage = 0.0;
    }

    public void addProduct(String productId, double price) {
        if (productId == null || productId.isEmpty() || price <= 0) {
            return;
        }
        productPrices.put(productId, price);
    }

    public void scan(String productId) {
        if (productId == null || !productPrices.containsKey(productId)) {
            return;
        }
        currentCart.put(productId, currentCart.getOrDefault(productId, 0) + 1);
    }

    public void voidItem(String productId) {
        if (productId == null || !currentCart.containsKey(productId)) {
            return;
        }
        int currentQuantity = currentCart.get(productId);
        if (currentQuantity > 1) {
            currentCart.put(productId, currentQuantity - 1);
        } else {
            currentCart.remove(productId);
        }
    }

    public double getTotal() {
        double subtotal = 0.0;
        for (Map.Entry<String, Integer> entry : currentCart.entrySet()) {
            String productId = entry.getKey();
            int quantity = entry.getValue();
            Double price = productPrices.get(productId);
            if (price != null) {
                subtotal += price * quantity;
            }
        }
        return subtotal * (1 - currentDiscountPercentage);
    }

    public void applyDiscountPercentage(double percentage) {
        if (percentage < 0.0 || percentage > 1.0) {
            return;
        }
        this.currentDiscountPercentage = percentage;
    }

    public void resetTransaction() {
        currentCart.clear();
        currentDiscountPercentage = 0.0;
    }
}