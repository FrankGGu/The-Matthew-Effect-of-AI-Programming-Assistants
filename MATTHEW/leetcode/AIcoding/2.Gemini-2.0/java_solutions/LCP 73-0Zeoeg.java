class Solution {
    public int maximumGroups(int[] grades) {
        Arrays.sort(grades);
        int groups = 0;
        int sum = 0;
        int count = 0;
        for (int grade : grades) {
            sum += grade;
            count++;
            if (sum >= (groups + 1) * (groups + 2) / 2) {
                groups++;
                sum = 0;
                count = 0;
            }
        }
        return groups;
    }
}