#include <map>
#include <set>

using namespace std;

class StockPrice {
public:
    StockPrice() {
        max_timestamp = 0;
    }

    void update(int timestamp, int price) {
        if (timestamp_to_price.count(timestamp)) {
            int old_price = timestamp_to_price[timestamp];
            price_to_timestamps[old_price].erase(timestamp);
            if (price_to_timestamps[old_price].empty()) {
                price_to_timestamps.erase(old_price);
            }
        }

        timestamp_to_price[timestamp] = price;
        price_to_timestamps[price].insert(timestamp);
        max_timestamp = max(max_timestamp, timestamp);
    }

    int current() {
        return timestamp_to_price[max_timestamp];
    }

    int maximum() {
        return price_to_timestamps.rbegin()->first;
    }

    int minimum() {
        return price_to_timestamps.begin()->first;
    }

private:
    map<int, int> timestamp_to_price;
    map<int, set<int>> price_to_timestamps;
    int max_timestamp;
};