#include <iostream>
#include <vector>
#include <map>
#include <unordered_map>

using namespace std;

class Solution {
public:
    void update(int timestamp, int price) {
        if (priceMap.find(timestamp) != priceMap.end()) {
            int oldPrice = priceMap[timestamp];
            priceToTimestamps[oldPrice].erase(timestamp);
            if (priceToTimestamps[oldPrice].empty()) {
                priceToTimestamps.erase(oldPrice);
            }
        }
        priceMap[timestamp] = price;
        priceToTimestamps[price].insert(timestamp);
    }

    int current(int timestamp) {
        return priceMap[timestamp];
    }

    int maximum() {
        return priceToTimestamps.rbegin()->first;
    }

    int minimum() {
        return priceToTimestamps.begin()->first;
    }

private:
    map<int, int> priceMap;
    map<int, unordered_set<int>> priceToTimestamps;
};