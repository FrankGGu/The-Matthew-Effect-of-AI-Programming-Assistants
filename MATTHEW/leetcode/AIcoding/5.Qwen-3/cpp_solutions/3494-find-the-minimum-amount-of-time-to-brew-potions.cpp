#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int minimumTimeToBrewPotions(vector<int>& potions, int k) {
        priority_queue<int, vector<int>, greater<int>> minHeap(potions.begin(), potions.end());
        int time = 0;
        while (minHeap.size() > 1) {
            int a = minHeap.top();
            minHeap.pop();
            int b = minHeap.top();
            minHeap.pop();
            int combined = a + b;
            time += combined;
            minHeap.push(combined);
        }
        return time;
    }
};