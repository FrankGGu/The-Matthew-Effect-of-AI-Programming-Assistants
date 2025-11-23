import java.util.HashMap;
import java.util.TreeMap;

class StockPrice {

    private HashMap<Integer, Integer> timestampPriceMap;
    private TreeMap<Integer, Integer> priceCountMap;
    private int latestTimestamp;

    public StockPrice() {
        timestampPriceMap = new HashMap<>();
        priceCountMap = new TreeMap<>();
        latestTimestamp = 0;
    }

    public void update(int timestamp, int price) {
        if (timestampPriceMap.containsKey(timestamp)) {
            int oldPrice = timestampPriceMap.get(timestamp);
            priceCountMap.put(oldPrice, priceCountMap.get(oldPrice) - 1);
            if (priceCountMap.get(oldPrice) == 0) {
                priceCountMap.remove(oldPrice);
            }
        }

        timestampPriceMap.put(timestamp, price);
        priceCountMap.put(price, priceCountMap.getOrDefault(price, 0) + 1);
        latestTimestamp = Math.max(latestTimestamp, timestamp);
    }

    public int current() {
        return timestampPriceMap.get(latestTimestamp);
    }

    public int maximum() {
        return priceCountMap.lastKey();
    }

    public int minimum() {
        return priceCountMap.firstKey();
    }
}