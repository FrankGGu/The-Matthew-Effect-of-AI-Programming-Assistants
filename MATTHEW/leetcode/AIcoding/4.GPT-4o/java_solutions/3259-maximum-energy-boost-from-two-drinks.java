class Solution {
    public int maxEnergyBoost(int[] energy) {
        int n = energy.length;
        if (n < 2) return 0;

        Arrays.sort(energy);
        return energy[n - 1] + energy[n - 2];
    }
}