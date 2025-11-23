import java.util.Arrays;

class Solution {
    public long dividePlayers(int[] skill) {
        Arrays.sort(skill);
        int n = skill.length;
        int target = skill[0] + skill[n - 1];
        long sum = 0;
        for (int i = 0; i < n / 2; i++) {
            if (skill[i] + skill[n - 1 - i] != target) {
                return -1;
            }
            sum += (long) skill[i] * skill[n - 1 - i];
        }
        return sum;
    }
}