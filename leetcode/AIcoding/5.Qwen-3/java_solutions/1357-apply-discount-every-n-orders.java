public class Solution {

import java.util.*;

public class Solution {
    public List<Integer> applyDiscounts(List<Integer> products, int n) {
        List<Integer> result = new ArrayList<>();
        int count = 0;
        for (int price : products) {
            count++;
            if (count % n == 0) {
                result.add(price / 2);
            } else {
                result.add(price);
            }
        }
        return result;
    }
}
}