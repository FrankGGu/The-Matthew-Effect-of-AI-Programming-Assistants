import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;

class StockPrice {

    private Map<Integer, Integer> timeToPrice;
    private TreeMap<Integer, Integer> priceCounts; // price -> count
    private int latestTimestamp;

    public StockPrice() {
        timeToPrice = new HashMap<>();
        priceCounts = new TreeMap<>();
        latestTimestamp = 0;
    }

    public void update(int timestamp, int price) {
        if (timestamp > latestTimestamp) {
            latestTimestamp = timestamp;
        }

        Integer oldPrice = timeToPrice.get(timestamp);
        if (oldPrice != null) {
            priceCounts.put(oldPrice, priceCounts.get(oldPrice) - 1);
            if (priceCounts.get(oldPrice) == 0) {
                priceCounts.remove(oldPrice);
            }
        }

        timeToPrice.put(timestamp, price);
        priceCounts.put(price, priceCounts.getOrDefault(price, 0) + 1);
    }

    public int current() {
        return timeToPrice.get(latestTimestamp);
    }

    public int maximum() {
        return priceCounts.lastKey();
    }

    public int minimum() {
        return priceCounts.firstKey();
    }
}