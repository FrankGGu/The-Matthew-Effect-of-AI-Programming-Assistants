class Solution {
    public int maximumDamage(int[] spell, int[][] spells) {
        int maxDamage = 0;
        for (int[] s : spells) {
            int damage = 0;
            for (int i = 0; i < spell.length; i++) {
                damage += spell[i] * s[i];
            }
            maxDamage = Math.max(maxDamage, damage);
        }
        return maxDamage;
    }
}