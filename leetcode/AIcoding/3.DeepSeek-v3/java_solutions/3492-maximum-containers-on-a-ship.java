import java.util.Arrays;

class Solution {
    public int maximumContainers(int[] weights, int capacity) {
        Arrays.sort(weights);
        int count = 0;
        int currentWeight = 0;

        for (int weight : weights) {
            if (currentWeight + weight <= capacity) {
                currentWeight += weight;
                count++;
            } else {
                break;
            }
        }

        return count;
    }
}