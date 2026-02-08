class Solution {
    public int[] supplyWagon(int[] supplies) {
        int n = supplies.length;
        int target = n / 2;
        while (supplies.length > target) {
            int minSum = Integer.MAX_VALUE;
            int mergeIndex = -1;
            for (int i = 0; i < supplies.length - 1; i++) {
                int sum = supplies[i] + supplies[i + 1];
                if (sum < minSum) {
                    minSum = sum;
                    mergeIndex = i;
                }
            }
            int[] newSupplies = new int[supplies.length - 1];
            System.arraycopy(supplies, 0, newSupplies, 0, mergeIndex);
            newSupplies[mergeIndex] = minSum;
            System.arraycopy(supplies, mergeIndex + 2, newSupplies, mergeIndex + 1, supplies.length - mergeIndex - 2);
            supplies = newSupplies;
        }
        return supplies;
    }
}