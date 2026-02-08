import java.util.*;

class StockPrice {
    private TreeMap<Integer, Integer> timePriceMap;
    private int latestTime;
    private int latestPrice;

    public StockPrice() {
        timePriceMap = new TreeMap<>();
        latestTime = 0;
        latestPrice = 0;
    }

    public void update(int timestamp, int price) {
        timePriceMap.put(timestamp, price);
        if (timestamp >= latestTime) {
            latestTime = timestamp;
            latestPrice = price;
        }
    }

    public int current() {
        return latestPrice;
    }

    public double maximum() {
        return timePriceMap.lastEntry().getValue();
    }

    public double minimum() {
        return timePriceMap.firstEntry().getValue();
    }
}