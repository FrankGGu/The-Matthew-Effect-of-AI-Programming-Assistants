class Solution {
public:
    int distanceBetweenBusStops(vector<int>& distance, int start, int destination) {
        if (start > destination) swap(start, destination);
        int totalDistance = accumulate(distance.begin(), distance.end(), 0);
        int directDistance = accumulate(distance.begin() + start, distance.begin() + destination, 0);
        return min(directDistance, totalDistance - directDistance);
    }
};