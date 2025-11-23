class Solution {
    public int minimumRefills(int[] plants, int capacityA, int capacityB) {
        int refills = 0;
        int waterA = capacityA;
        int waterB = capacityB;
        int left = 0;
        int right = plants.length - 1;

        while (left < right) {
            // Alice waters from the left
            if (waterA < plants[left]) {
                refills++;
                waterA = capacityA; 
            }
            waterA -= plants[left];

            // Bob waters from the right
            if (waterB < plants[right]) {
                refills++;
                waterB = capacityB; 
            }
            waterB -= plants[right];

            left++;
            right--;
        }

        // If there's a middle plant (odd number of plants)
        if (left == right) {
            // Determine who waters the middle plant based on capacity rules
            if (capacityA >= capacityB) { // Alice waters
                if (waterA < plants[left]) {
                    refills++;
                }
            } else { // Bob waters
                if (waterB < plants[left]) { 
                    refills++;
                }
            }
        }

        return refills;
    }
}