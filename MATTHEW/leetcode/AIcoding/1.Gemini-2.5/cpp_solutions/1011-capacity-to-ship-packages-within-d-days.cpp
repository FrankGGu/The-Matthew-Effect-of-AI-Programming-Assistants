class Solution {
public:
    bool canShip(int capacity, const std::vector<int>& weights, int D) {
        int daysNeeded = 1;
        int currentWeight = 0;
        for (int weight : weights) {
            if (weight > capacity) {
                return false;
            }
            if (currentWeight + weight <= capacity) {
                currentWeight += weight;
            } else {
                daysNeeded++;
                currentWeight = weight;
            }
        }
        return daysNeeded <= D;
    }

    int shipWithinDays(std::vector<int>& weights, int D) {
        int low = 0;
        int high = 0;
        for (int weight : weights) {
            low = std::max(low, weight);
            high += weight;
        }

        int result = high;

        while (low <= high) {
            int mid = low + (high - low) / 2;
            if (canShip(mid, weights, D)) {
                result = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        return result;
    }
};