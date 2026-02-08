class Solution {
public:
    int minimumRefill(vector<int>& plants, int capacityA, int capacityB) {
        int n = plants.size();
        int left = 0, right = n - 1;
        int refill = 0;
        int currentA = capacityA, currentB = capacityB;

        while (left <= right) {
            if (left == right) {
                if (max(currentA, currentB) < plants[left]) {
                    refill++;
                }
                break;
            }

            if (currentA < plants[left]) {
                refill++;
                currentA = capacityA;
            }
            currentA -= plants[left];
            left++;

            if (currentB < plants[right]) {
                refill++;
                currentB = capacityB;
            }
            currentB -= plants[right];
            right--;
        }

        return refill;
    }
};