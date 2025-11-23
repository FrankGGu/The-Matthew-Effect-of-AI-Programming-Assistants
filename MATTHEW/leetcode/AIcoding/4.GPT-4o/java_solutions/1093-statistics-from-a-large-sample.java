class Solution {
    public String sampleStats(int[] count) {
        int total = 0, min = Integer.MAX_VALUE, max = Integer.MIN_VALUE;
        double sum = 0;
        for (int i = 0; i < count.length; i++) {
            if (count[i] > 0) {
                min = Math.min(min, i);
                max = Math.max(max, i);
                total += count[i];
                sum += i * count[i];
            }
        }
        double mean = sum / total;
        double median = 0;
        int mid = total / 2;
        int currentCount = 0;
        for (int i = 0; i < count.length; i++) {
            currentCount += count[i];
            if (currentCount > mid) {
                median = i;
                break;
            }
            if (currentCount == mid) {
                median = i;
                for (int j = i + 1; j < count.length; j++) {
                    if (count[j] > 0) {
                        median = (median + j) / 2;
                        break;
                    }
                }
                break;
            }
        }
        double mode = 0;
        int maxCount = 0;
        for (int i = 0; i < count.length; i++) {
            if (count[i] > maxCount) {
                maxCount = count[i];
                mode = i;
            }
        }
        return String.format("%.2f\n%.2f\n%.2f\n%d\n%d", min * 1.0, max * 1.0, mean, (int) median, (int) mode);
    }
}