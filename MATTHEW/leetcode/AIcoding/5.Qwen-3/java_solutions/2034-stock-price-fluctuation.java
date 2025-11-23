public class Solution {

import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;

public class StockPriceFluctuation {
    private Map<Integer, Integer> timeToPrice;
    private TreeMap<Integer, Integer> priceCount;

    public StockPriceFluctuation() {
        timeToPrice = new HashMap<>();
        priceCount = new TreeMap<>();
    }

    public void update(int timestamp, int price) {
        if (timeToPrice.containsKey(timestamp)) {
            int oldPrice = timeToPrice.get(timestamp);
            priceCount.put(oldPrice, priceCount.get(oldPrice) - 1);
            if (priceCount.get(oldPrice) == 0) {
                priceCount.remove(oldPrice);
            }
        }
        timeToPrice.put(timestamp, price);
        priceCount.put(price, priceCount.getOrDefault(price, 0) + 1);
    }

    public int current() {
        return timeToPrice.get(timeToPrice.size());
    }

    public int maximum() {
        return priceCount.lastKey();
    }

    public int minimum() {
        return priceCount.firstKey();
    }
}
}