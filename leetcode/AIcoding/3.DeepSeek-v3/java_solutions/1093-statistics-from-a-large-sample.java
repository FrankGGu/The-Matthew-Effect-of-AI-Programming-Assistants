class Solution {
    public double[] sampleStats(int[] count) {
        double[] result = new double[5];
        // minimum
        for (int i = 0; i < count.length; i++) {
            if (count[i] > 0) {
                result[0] = i;
                break;
            }
        }
        // maximum
        for (int i = count.length - 1; i >= 0; i--) {
            if (count[i] > 0) {
                result[1] = i;
                break;
            }
        }
        // mean
        double sum = 0;
        int total = 0;
        for (int i = 0; i < count.length; i++) {
            sum += (double) i * count[i];
            total += count[i];
        }
        result[2] = sum / total;
        // median
        int cnt = 0;
        int median1 = -1, median2 = -1;
        for (int i = 0; i < count.length; i++) {
            cnt += count[i];
            if (median1 == -1 && cnt >= (total + 1) / 2) {
                median1 = i;
            }
            if (median2 == -1 && cnt >= (total + 2) / 2) {
                median2 = i;
            }
        }
        result[3] = (median1 + median2) / 2.0;
        // mode
        int maxCount = 0;
        int mode = 0;
        for (int i = 0; i < count.length; i++) {
            if (count[i] > maxCount) {
                maxCount = count[i];
                mode = i;
            }
        }
        result[4] = mode;
        return result;
    }
}