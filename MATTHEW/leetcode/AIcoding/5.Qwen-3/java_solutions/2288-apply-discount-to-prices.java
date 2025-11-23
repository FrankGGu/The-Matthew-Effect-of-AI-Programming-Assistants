public class Solution {

import java.util.*;

public class Solution {
    public String[] discountPrices(String[] prices, int discount) {
        String[] result = new String[prices.length];
        for (int i = 0; i < prices.length; i++) {
            String price = prices[i];
            if (price.charAt(0) == '$' && price.length() > 1) {
                boolean isValid = true;
                for (int j = 1; j < price.length(); j++) {
                    if (!Character.isDigit(price.charAt(j))) {
                        isValid = false;
                        break;
                    }
                }
                if (isValid) {
                    long originalPrice = Long.parseLong(price.substring(1));
                    long discountedPrice = originalPrice * (100 - discount) / 100;
                    result[i] = "$" + discountedPrice;
                } else {
                    result[i] = price;
                }
            } else {
                result[i] = price;
            }
        }
        return result;
    }
}
}