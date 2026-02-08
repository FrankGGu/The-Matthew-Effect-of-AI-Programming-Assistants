class Solution {
public:
    int maximizeSweetness(vector<int>& sweetness, int K) {
        int low = 1, high = accumulate(sweetness.begin(), sweetness.end(), 0) / (K + 1);

        while (low < high) {
            int mid = low + (high - low + 1) / 2;
            if (canDivide(sweetness, mid, K)) {
                low = mid;
            } else {
                high = mid - 1;
            }
        }

        return low;
    }

    bool canDivide(vector<int>& sweetness, int target, int K) {
        int count = 0, currentSum = 0;
        for (int s : sweetness) {
            currentSum += s;
            if (currentSum >= target) {
                count++;
                currentSum = 0;
            }
        }
        return count >= K + 1;
    }
};