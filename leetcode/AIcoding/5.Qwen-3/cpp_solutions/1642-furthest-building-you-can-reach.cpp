#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int furthestBuilding(vector<int>& buildings, int boomerangs, int bricks) {
        priority_queue<int> maxHeap;
        int i = 0;
        for (; i < buildings.size() - 1; ++i) {
            int diff = buildings[i + 1] - buildings[i];
            if (diff > 0) {
                if (boomerangs > 0) {
                    maxHeap.push(diff);
                    boomerangs--;
                } else {
                    if (maxHeap.empty() || diff < maxHeap.top()) {
                        if (bricks >= diff) {
                            bricks -= diff;
                        } else {
                            return i;
                        }
                    } else {
                        int top = maxHeap.top();
                        maxHeap.pop();
                        bricks += top - diff;
                    }
                }
            }
        }
        return i;
    }
};