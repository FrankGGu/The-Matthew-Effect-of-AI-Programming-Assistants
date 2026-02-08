import java.util.Arrays;

class Solution {
    public int storeWater(int[] bucket, int[] vat) {
        int n = bucket.length;
        int totalUpgrades = 0;

        // Iterate through each vat and its corresponding bucket.
        for (int i = 0; i < n; i++) {
            // If a vat has a target water level of 0, no water is needed for it.
            // Therefore, no operations (upgrades or pours) are required for this vat.
            if (vat[i] == 0) {
                continue;
            }

            // If a vat needs water (vat[i] > 0), we must ensure its corresponding bucket
            // has a capacity of at least 1 to be able to pour water.
            // The problem specifies "minimize the total cost (number of bucket upgrades)".
            // This means only bucket upgrades count towards the total cost; pouring operations are free.

            // If the current bucket capacity (bucket[i]) is 0, we must upgrade it.
            // An upgrade operation increases bucket[i] by 1. To be able to pour,
            // we need to upgrade bucket[i] to at least 1. This costs 1 upgrade.
            if (bucket[i] == 0) {
                totalUpgrades++;
            }
            // If bucket[i] is already greater than 0, it can be used to pour water.
            // No upgrades are necessary for this bucket, so it contributes 0 to the total upgrades cost.
            // The number of times we pour (ceil(vat[i] / bucket[i])) does not count as a cost.
        }

        return totalUpgrades;
    }
}