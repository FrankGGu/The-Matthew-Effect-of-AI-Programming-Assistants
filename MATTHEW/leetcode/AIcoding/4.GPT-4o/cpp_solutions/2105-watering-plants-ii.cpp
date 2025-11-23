class Solution {
public:
    int minimumRefill(vector<int>& plants, int capacityA, int capacityB) {
        int n = plants.size();
        int refills = 0, a = capacityA, b = capacityB;

        for (int i = 0; i < n; ++i) {
            if (i % 2 == 0) {
                if (a < plants[i]) {
                    refills++;
                    a = capacityA;
                }
                a -= plants[i];
            } else {
                if (b < plants[i]) {
                    refills++;
                    b = capacityB;
                }
                b -= plants[i];
            }
        }

        return refills;
    }
};