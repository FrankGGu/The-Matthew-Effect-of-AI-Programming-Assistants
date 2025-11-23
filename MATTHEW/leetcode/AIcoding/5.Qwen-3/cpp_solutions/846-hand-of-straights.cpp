#include <iostream>
#include <vector>
#include <map>
#include <queue>

using namespace std;

class Solution {
public:
    vector<int> handOfStraights(vector<int>& hand, int groupSize) {
        if (hand.size() % groupSize != 0) return {};

        map<int, int> count;
        for (int card : hand) {
            count[card]++;
        }

        priority_queue<int, vector<int>, greater<int>> minHeap;
        for (int card : hand) {
            minHeap.push(card);
        }

        vector<int> result;
        while (!minHeap.empty()) {
            int first = minHeap.top();
            for (int i = 0; i < groupSize; ++i) {
                if (count[first + i] == 0) return {};
                count[first + i]--;
                result.push_back(first + i);
                if (count[first + i] == 0) {
                    minHeap.pop();
                }
            }
        }

        return result;
    }
};