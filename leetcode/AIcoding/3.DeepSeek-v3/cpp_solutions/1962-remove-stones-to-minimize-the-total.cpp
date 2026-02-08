class Solution {
public:
    int minStoneSum(vector<int>& piles, int k) {
        priority_queue<int> maxHeap(piles.begin(), piles.end());
        for (int i = 0; i < k; ++i) {
            int top = maxHeap.top();
            maxHeap.pop();
            top -= top / 2;
            maxHeap.push(top);
        }
        int total = 0;
        while (!maxHeap.empty()) {
            total += maxHeap.top();
            maxHeap.pop();
        }
        return total;
    }
};