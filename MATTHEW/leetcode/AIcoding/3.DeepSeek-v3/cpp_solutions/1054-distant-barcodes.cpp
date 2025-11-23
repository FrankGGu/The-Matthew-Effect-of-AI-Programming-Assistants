#include <vector>
#include <queue>
#include <unordered_map>
using namespace std;

class Solution {
public:
    vector<int> rearrangeBarcodes(vector<int>& barcodes) {
        unordered_map<int, int> freq;
        for (int num : barcodes) {
            freq[num]++;
        }

        priority_queue<pair<int, int>> pq;
        for (auto& [num, count] : freq) {
            pq.push({count, num});
        }

        vector<int> result;
        while (!pq.empty()) {
            auto [count1, num1] = pq.top();
            pq.pop();

            if (result.empty() || result.back() != num1) {
                result.push_back(num1);
                if (--count1 > 0) {
                    pq.push({count1, num1});
                }
            } else {
                if (pq.empty()) {
                    break;
                }

                auto [count2, num2] = pq.top();
                pq.pop();
                result.push_back(num2);
                if (--count2 > 0) {
                    pq.push({count2, num2});
                }

                pq.push({count1, num1});
            }
        }

        return result;
    }
};