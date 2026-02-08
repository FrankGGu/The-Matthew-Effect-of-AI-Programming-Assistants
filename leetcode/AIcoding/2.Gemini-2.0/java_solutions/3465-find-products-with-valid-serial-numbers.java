import java.util.List;
import java.util.ArrayList;

class Solution {
    public List<String> findProducts(List<String> products, List<String> serials) {
        List<String> result = new ArrayList<>();
        for (String serial : serials) {
            boolean found = false;
            for (String product : products) {
                if (product.contains(serial)) {
                    result.add(product);
                    found = true;
                    break;
                }
            }
            if (!found) {
                result.add("");
            }
        }
        return result;
    }
}