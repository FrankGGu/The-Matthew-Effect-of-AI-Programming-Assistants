import java.util.List;

class Solution {
    public List<List<String>> fillMissingData(List<List<String>> products) {
        for (int i = 0; i < products.size(); i++) {
            List<String> product = products.get(i);
            for (int j = 0; j < product.size(); j++) {
                if (product.get(j).equals("")) {
                    if (i > 0 && !products.get(i - 1).get(j).equals("")) {
                        product.set(j, products.get(i - 1).get(j));
                    } else if (i < products.size() - 1 && !products.get(i + 1).get(j).equals("")) {
                        product.set(j, products.get(i + 1).get(j));
                    }
                }
            }
        }
        return products;
    }
}