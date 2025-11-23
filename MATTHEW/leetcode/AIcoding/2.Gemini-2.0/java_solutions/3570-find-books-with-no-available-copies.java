import java.util.List;
import java.util.ArrayList;

class Solution {
    public List<String> findBooks(List<List<String>> bookOrders) {
        List<String> result = new ArrayList<>();
        for (List<String> order : bookOrders) {
            String bookId = order.get(0);
            int quantity = Integer.parseInt(order.get(1));
            int available = Integer.parseInt(order.get(2));

            if (quantity > available) {
                result.add(bookId);
            }
        }
        return result;
    }
}