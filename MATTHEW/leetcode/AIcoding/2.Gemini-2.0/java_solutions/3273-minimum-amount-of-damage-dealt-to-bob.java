class Solution {
    public int minDamage(int[] armor, int[] damage, int p) {
        int n = armor.length;
        int maxArmor = 0;
        int totalDamage = 0;
        for (int i = 0; i < n; i++) {
            totalDamage += damage[i];
            maxArmor = Math.max(maxArmor, Math.min(armor[i], damage[i]));
        }
        return Math.max(0, totalDamage - Math.min(maxArmor, p));
    }
}