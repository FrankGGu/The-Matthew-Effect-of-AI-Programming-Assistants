class Solution {
    public int inventoryManagement(int[] stock) {
        int candidate = 0;
        int count = 0;

        for (int num : stock) {
            if (count == 0) {
                candidate = num;
                count = 1;
            } else if (candidate == num) {
                count++;
            } else {
                count--;
            }
        }

        return candidate;
    }
}