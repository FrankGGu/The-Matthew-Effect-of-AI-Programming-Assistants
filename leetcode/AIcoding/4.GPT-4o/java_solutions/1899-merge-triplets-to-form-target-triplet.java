class Solution {
    public boolean mergeTriplets(int[][] triplets, int[] target) {
        int[] max = new int[3];
        for (int[] triplet : triplets) {
            if (triplet[0] > target[0] || triplet[1] > target[1] || triplet[2] > target[2]) continue;
            max[0] = Math.max(max[0], triplet[0]);
            max[1] = Math.max(max[1], triplet[1]);
            max[2] = Math.max(max[2], triplet[2]);
        }
        return Arrays.equals(max, target);
    }
}