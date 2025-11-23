int furthestBuilding(int* heights, int heightsSize, int bricks, int ladders) {
    priority_queue<int, vector<int>, greater<int>> minHeap;
    for (int i = 0; i < heightsSize - 1; i++) {
        int diff = heights[i + 1] - heights[i];
        if (diff > 0) {
            minHeap.push(diff);
        }
        if (minHeap.size() > ladders) {
            bricks -= minHeap.top();
            minHeap.pop();
        }
        if (bricks < 0) {
            return i;
        }
    }
    return heightsSize - 1;
}