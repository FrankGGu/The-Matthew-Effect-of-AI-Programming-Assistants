class Solution {
    public double average(int[] salary) {
        int minSalary = Integer.MAX_VALUE;
        int maxSalary = Integer.MIN_VALUE;
        long totalSum = 0;

        for (int s : salary) {
            if (s < minSalary) {
                minSalary = s;
            }
            if (s > maxSalary) {
                maxSalary = s;
            }
            totalSum += s;
        }

        totalSum -= minSalary;
        totalSum -= maxSalary;

        return (double) totalSum / (salary.length - 2);
    }
}