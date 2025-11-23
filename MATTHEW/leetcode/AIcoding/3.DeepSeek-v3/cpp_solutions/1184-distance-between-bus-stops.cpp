class Solution {
public:
    int distanceBetweenBusStops(vector<int>& distance, int start, int destination) {
        int total = 0;
        int forward = 0;
        int n = distance.size();
        if (start > destination) {
            swap(start, destination);
        }
        for (int i = 0; i < n; ++i) {
            if (i >= start && i < destination) {
                forward += distance[i];
            }
            total += distance[i];
        }
        return min(forward, total - forward);
    }
};