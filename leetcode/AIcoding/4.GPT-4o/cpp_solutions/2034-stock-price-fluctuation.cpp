class StockPrice {
public:
    StockPrice() {}

    void update(int timestamp, int price) {
        if (prices.count(timestamp)) {
            prices[timestamp] = price;
        } else {
            prices.insert({timestamp, price});
        }
        maxHeap.push({price, timestamp});
        minHeap.push({-price, timestamp});
    }

    int current() {
        return prices.rbegin()->second;
    }

    int maximum() {
        while (!maxHeap.empty() && prices[maxHeap.top().second] != maxHeap.top().first) {
            maxHeap.pop();
        }
        return maxHeap.top().first;
    }

    int minimum() {
        while (!minHeap.empty() && prices[minHeap.top().second] != -minHeap.top().first) {
            minHeap.pop();
        }
        return -minHeap.top().first;
    }

private:
    unordered_map<int, int> prices;
    priority_queue<pair<int, int>> maxHeap;
    priority_queue<pair<int, int>> minHeap;
};