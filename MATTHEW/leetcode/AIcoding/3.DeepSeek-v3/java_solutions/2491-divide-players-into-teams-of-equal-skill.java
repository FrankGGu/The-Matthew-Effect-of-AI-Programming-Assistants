class Solution {
    public long dividePlayers(int[] skill) {
        Arrays.sort(skill);
        int n = skill.length;
        int target = skill[0] + skill[n - 1];
        long res = (long) skill[0] * skill[n - 1];

        for (int i = 1; i < n / 2; i++) {
            int sum = skill[i] + skill[n - 1 - i];
            if (sum != target) {
                return -1;
            }
            res += (long) skill[i] * skill[n - 1 - i];
        }
        return res;
    }
}