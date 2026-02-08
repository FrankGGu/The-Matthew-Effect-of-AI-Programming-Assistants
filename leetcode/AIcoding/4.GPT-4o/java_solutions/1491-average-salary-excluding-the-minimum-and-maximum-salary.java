class Solution {
    public double average(int[] salary) {
        int min = Integer.MAX_VALUE, max = Integer.MIN_VALUE, sum = 0;
        for (int s : salary) {
            sum += s;
            if (s < min) min = s;
            if (s > max) max = s;
        }
        return (sum - min - max) / (double)(salary.length - 2);
    }
}