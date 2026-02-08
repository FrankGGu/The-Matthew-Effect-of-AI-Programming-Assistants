class Solution {
public:
    int shipWithinDays(vector<int>& weights, int D) {
        int left = *max_element(weights.begin(), weights.end());
        int right = accumulate(weights.begin(), weights.end(), 0);

        while (left < right) {
            int mid = left + (right - left) / 2;
            int days = 1, currentWeight = 0;

            for (int weight : weights) {
                if (currentWeight + weight > mid) {
                    days++;
                    currentWeight = weight;
                } else {
                    currentWeight += weight;
                }
            }

            if (days > D) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }

        return left;
    }
};