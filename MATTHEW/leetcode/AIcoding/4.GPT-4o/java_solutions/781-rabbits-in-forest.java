class Solution {
    public int numRabbits(int[] answers) {
        int[] count = new int[1000];
        int result = 0;

        for (int answer : answers) {
            count[answer]++;
        }

        for (int i = 0; i < count.length; i++) {
            if (count[i] > 0) {
                result += ((count[i] + i) / (i + 1)) * (i + 1);
            }
        }

        return result;
    }
}