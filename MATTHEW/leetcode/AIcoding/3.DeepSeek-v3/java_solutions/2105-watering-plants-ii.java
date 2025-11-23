class Solution {
    public int minimumRefill(int[] plants, int capacityA, int capacityB) {
        int n = plants.length;
        int left = 0, right = n - 1;
        int refill = 0;
        int a = capacityA, b = capacityB;

        while (left <= right) {
            if (left == right) {
                if (a >= b) {
                    if (a < plants[left]) {
                        refill++;
                        a = capacityA;
                    }
                    a -= plants[left];
                } else {
                    if (b < plants[right]) {
                        refill++;
                        b = capacityB;
                    }
                    b -= plants[right];
                }
                break;
            }

            if (a < plants[left]) {
                refill++;
                a = capacityA;
            }
            a -= plants[left];
            left++;

            if (b < plants[right]) {
                refill++;
                b = capacityB;
            }
            b -= plants[right];
            right--;
        }

        return refill;
    }
}