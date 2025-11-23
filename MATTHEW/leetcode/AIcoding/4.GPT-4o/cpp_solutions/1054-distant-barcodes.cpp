#include <vector>
#include <unordered_map>
#include <queue>

using namespace std;

vector<int> rearrangeBarcodes(vector<int>& barcodes) {
    unordered_map<int, int> count;
    for (int b : barcodes) {
        count[b]++;
    }

    priority_queue<pair<int, int>> pq;
    for (const auto& entry : count) {
        pq.push({entry.second, entry.first});
    }

    vector<int> result;
    pair<int, int> prev = {0, 0}; // (count, barcode)

    while (!pq.empty()) {
        auto curr = pq.top(); pq.pop();
        result.push_back(curr.second);

        if (prev.first > 0) {
            pq.push(prev);
        }

        prev = {curr.first - 1, curr.second};
    }

    return result;
}