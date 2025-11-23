import java.util.ArrayList;
import java.util.List;

class ProductRow {
    public int product_id;
    public Integer store1;
    public Integer store2;
    public Integer store3;

    public ProductRow(int product_id, Integer store1, Integer store2, Integer store3) {
        this.product_id = product_id;
        this.store1 = store1;
        this.store2 = store2;
        this.store3 = store3;
    }
}

class PivotedProductRow {
    public int product_id;
    public String store;
    public int price;

    public PivotedProductRow(int product_id, String store, int price) {
        this.product_id = product_id;
        this.store = store;
        this.price = price;
    }
}

class Solution {
    public List<PivotedProductRow> pivotData(List<ProductRow> products) {
        List<PivotedProductRow> pivotedList = new ArrayList<>();

        for (ProductRow product : products) {
            if (product.store1 != null) {
                pivotedList.add(new PivotedProductRow(product.product_id, "store1", product.store1));
            }
            if (product.store2 != null) {
                pivotedList.add(new PivotedProductRow(product.product_id, "store2", product.store2));
            }
            if (product.store3 != null) {
                pivotedList.add(new PivotedProductRow(product.product_id, "store3", product.store3));
            }
        }
        return pivotedList;
    }
}