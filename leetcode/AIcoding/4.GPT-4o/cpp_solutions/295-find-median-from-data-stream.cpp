class MedianFinder {
public:
    priority_queue<int> maxHeap; // max heap for the lower half
    priority_queue<int, vector<int>, greater<int>> minHeap; // min heap for the upper half

    MedianFinder() {}

    void addNum(int num) {
        maxHeap.push(num);
        minHeap.push(maxHeap.top());
        maxHeap.pop();
        if (maxHeap.size() < minHeap.size()) {
            maxHeap.push(minHeap.top());
            minHeap.pop();
        }
    }

    double findMedian() {
        if (maxHeap.size() > minHeap.size()) {
            return maxHeap.top();
        }
        return (maxHeap.top() + minHeap.top()) / 2.0;
    }
};