import java.util.*;

public class ShoppingOffers {

    public int shoppingOffers(List<Integer> price, List<List<Integer>> special, List<Integer> needs) {
        return helper(price, special, needs);
    }

    private int helper(List<Integer> price, List<List<Integer>> special, List<Integer> needs) {
        int minPrice = directPurchase(price, needs);

        for (List<Integer> offer : special) {
            List<Integer> newNeeds = new ArrayList<>(needs);
            boolean valid = true;
            for (int i = 0; i < needs.size(); i++) {
                int diff = needs.get(i) - offer.get(i);
                if (diff < 0) {
                    valid = false;
                    break;
                }
                newNeeds.set(i, diff);
            }

            if (valid) {
                minPrice = Math.min(minPrice, offer.get(offer.size() - 1) + helper(price, special, newNeeds));
            }
        }

        return minPrice;
    }

    private int directPurchase(List<Integer> price, List<Integer> needs) {
        int totalPrice = 0;
        for (int i = 0; i < price.size(); i++) {
            totalPrice += price.get(i) * needs.get(i);
        }
        return totalPrice;
    }
}