public class Solution {

import java.util.Arrays;

public class Solution {
    public long dividePlayers(int[] skill) {
        Arrays.sort(skill);
        int n = skill.length;
        long total = 0;
        for (int i = 0; i < n / 2; i++) {
            if (skill[i] + skill[n - 1 - i] != skill[0] + skill[n - 1]) {
                return -1;
            }
            total += (long) skill[i] * skill[n - 1 - i];
        }
        return total;
    }
}
}