public class Solution {
    public int trainingPlan(int[] plants, int capacity) {
        int current = 0;
        int count = 0;
        for (int plant : plants) {
            if (current + plant > capacity) {
                count++;
                current = plant;
            } else {
                current += plant;
            }
        }
        return count + 1;
    }
}