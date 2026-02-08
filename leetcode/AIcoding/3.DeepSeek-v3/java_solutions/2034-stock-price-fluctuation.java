class StockPrice {
    private TreeMap<Integer, Integer> timeToPrice;
    private TreeMap<Integer, Integer> priceCount;

    public StockPrice() {
        timeToPrice = new TreeMap<>();
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
        return timeToPrice.lastEntry().getValue();
    }

    public int maximum() {
        return priceCount.lastKey();
    }

    public int minimum() {
        return priceCount.firstKey();
    }
}