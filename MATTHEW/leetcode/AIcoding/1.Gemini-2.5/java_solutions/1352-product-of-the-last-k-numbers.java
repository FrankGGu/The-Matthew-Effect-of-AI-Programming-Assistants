import java.util.ArrayList;
import java.util.List;

class ProductOfNumbers {

    private List<Integer> products;

    public ProductOfNumbers() {
        products = new ArrayList<>();
        products.add(1); // Sentinel value for prefix product
    }

    public void add(int num) {
        if (num == 0) {
            products.clear();
            products.add(1);
        } else {
            products.add(products.get(products.size() - 1) * num);
        }
    }

    public int getProduct(int k) {
        if (k >= products.size()) {
            return 0;
        } else {
            return products.get(products.size() - 1) / products.get(products.size() - 1 - k);
        }
    }
}