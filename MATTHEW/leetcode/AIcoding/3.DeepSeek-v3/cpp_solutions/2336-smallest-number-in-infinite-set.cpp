#include <queue>
#include <unordered_set>
#include <vector>
using namespace std;

class SmallestInfiniteSet {
private:
    int current;
    priority_queue<int, vector<int>, greater<int>> minHeap;
    unordered_set<int> inHeap;

public:
    SmallestInfiniteSet() {
        current = 1;
    }

    int popSmallest() {
        if (!minHeap.empty()) {
            int smallest = minHeap.top();
            minHeap.pop();
            inHeap.erase(smallest);
            return smallest;
        }
        return current++;
    }

    void addBack(int num) {
        if (num < current && inHeap.find(num) == inHeap.end()) {
            minHeap.push(num);
            inHeap.insert(num);
        }
    }
};