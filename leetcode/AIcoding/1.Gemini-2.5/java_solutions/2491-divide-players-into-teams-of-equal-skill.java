import java.util.Arrays;

class Solution {
    public long dividePlayers(int[] skill) {
        Arrays.sort(skill);

        int n = skill.length;
        long totalChemistry = 0;

        // The target sum for each team must be skill[0] + skill[n-1]
        int targetTeamSkillSum = skill[0] + skill[n - 1];

        for (int i = 0; i < n / 2; i++) {
            // Check if the current pair (smallest remaining and largest remaining)
            // sums up to the targetTeamSkillSum
            if (skill[i] + skill[n - 1 - i] != targetTeamSkillSum) {
                return -1; // Impossible to form teams with equal skill sum
            }
            // If it matches, add the chemistry for this team
            totalChemistry += (long) skill[i] * skill[n - 1 - i];
        }

        return totalChemistry;
    }
}