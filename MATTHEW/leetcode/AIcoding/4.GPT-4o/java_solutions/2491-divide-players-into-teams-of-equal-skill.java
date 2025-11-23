import java.util.Arrays;

class Solution {
    public long dividePlayers(int[] skill) {
        Arrays.sort(skill);
        long totalSkill = 0;
        long sumProduct = 0;
        int n = skill.length;

        for (int i = 0; i < n / 2; i++) {
            totalSkill += skill[i] + skill[n - 1 - i];
            sumProduct += (long) skill[i] * skill[n - 1 - i];
        }

        if (totalSkill * n % 2 != 0) return -1;

        return sumProduct;
    }
}