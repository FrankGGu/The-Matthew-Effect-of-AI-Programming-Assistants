class StockPrice {
private:
    map<int, int> timeToPrice;
    multiset<int> prices;

public:
    StockPrice() {

    }

    void update(int timestamp, int price) {
        if (timeToPrice.count(timestamp)) {
            int oldPrice = timeToPrice[timestamp];
            prices.erase(prices.find(oldPrice));
        }
        timeToPrice[timestamp] = price;
        prices.insert(price);
    }

    int current() {
        return timeToPrice.rbegin()->second;
    }

    int maximum() {
        return *prices.rbegin();
    }

    int minimum() {
        return *prices.begin();
    }
};