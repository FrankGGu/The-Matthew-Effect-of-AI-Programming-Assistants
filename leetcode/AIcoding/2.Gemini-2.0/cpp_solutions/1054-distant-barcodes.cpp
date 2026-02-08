#include <vector>
#include <algorithm>
#include <unordered_map>
#include <queue>

using namespace std;

class Solution {
public:
    vector<int> rearrangeBarcodes(vector<int>& barcodes) {
        unordered_map<int, int> counts;
        for (int barcode : barcodes) {
            counts[barcode]++;
        }

        priority_queue<pair<int, int>> pq;
        for (auto const& [barcode, count] : counts) {
            pq.push({count, barcode});
        }

        vector<int> result;
        int prevBarcode = -1;
        while (!pq.empty()) {
            auto [count, barcode] = pq.top();
            pq.pop();

            result.push_back(barcode);

            if (prevBarcode != -1) {
                pq.push({counts[prevBarcode], prevBarcode});
                counts[prevBarcode]--;
            }

            counts[barcode]--;
            prevBarcode = barcode;
        }

        return result;
    }
};