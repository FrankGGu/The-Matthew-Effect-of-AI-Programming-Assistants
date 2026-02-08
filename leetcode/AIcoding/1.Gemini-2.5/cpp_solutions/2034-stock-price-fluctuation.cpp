#include <unordered_map>
#include <set>
#include <algorithm>

class StockPrice {
private:
    std::unordered_map<int, int> timestamp_to_price;
    std::multiset<int> prices;
    int latest_timestamp;

public:
    StockPrice() {
        latest_timestamp = 0;
    }

    void update(int timestamp, int price) {
        if (timestamp_to_price.count(timestamp)) {
            int old_price = timestamp_to_price[timestamp];
            prices.erase(prices.find(old_price));
        }
        timestamp_to_price[timestamp] = price;
        prices.insert(price);
        latest_timestamp = std::max(latest_timestamp, timestamp);
    }

    int current() {
        return timestamp_to_price[latest_timestamp];
    }

    int maximum() {
        return *prices.rbegin();
    }

    int minimum() {
        return *prices.begin();
    }
};