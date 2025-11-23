class Solution {
    public boolean mergeTriplets(int[][] triplets, int[] target) {
        boolean foundX = false;
        boolean foundY = false;
        boolean foundZ = false;

        for (int[] triplet : triplets) {
            if (triplet[0] <= target[0] && triplet[1] <= target[1] && triplet[2] <= target[2]) {
                if (triplet[0] == target[0]) {
                    foundX = true;
                }
                if (triplet[1] == target[1]) {
                    foundY = true;
                }
                if (triplet[2] == target[2]) {
                    foundZ = true;
                }
            }
        }

        return foundX && foundY && foundZ;
    }
}