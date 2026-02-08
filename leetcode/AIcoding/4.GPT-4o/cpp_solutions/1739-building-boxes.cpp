class Solution {
public:
    int minimumBoxes(int n) {
        int boxes = 0, total = 0, k = 0;

        while (total + (k + 1) * (k + 2) / 2 <= n) {
            k++;
            total += k * (k + 1) / 2;
        }

        boxes = k * (k + 1) / 2;

        int remaining = n - total;
        while (remaining > 0) {
            boxes++;
            remaining -= k;
            k--;
        }

        return boxes;
    }
};