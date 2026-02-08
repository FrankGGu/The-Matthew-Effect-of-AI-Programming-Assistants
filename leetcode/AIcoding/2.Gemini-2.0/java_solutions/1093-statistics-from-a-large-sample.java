class Solution {
    public double[] sampleStats(int[] count) {
        long total = 0;
        for (int c : count) {
            total += c;
        }

        double min = -1, max = -1, mean = 0, median = 0;
        long mode = 0;
        int modeIndex = 0;

        for (int i = 0; i < count.length; i++) {
            if (count[i] > 0) {
                if (min == -1) {
                    min = i;
                }
                max = i;
                mean += (double) i * count[i];

                if (count[i] > mode) {
                    mode = count[i];
                    modeIndex = i;
                }
            }
        }

        mean /= total;

        long left = 0;
        int leftIndex = -1;
        int rightIndex = -1;

        for (int i = 0; i < count.length; i++) {
            if (count[i] > 0) {
                if (left < (total + 1) / 2 && left + count[i] >= (total + 1) / 2) {
                    leftIndex = i;
                }
                left += count[i];
                if (left < (total + 2) / 2 && left + count[i] >= (total + 2) / 2) {
                    rightIndex = i;
                }
            }
        }

        if (total % 2 == 0) {
            median = (leftIndex + rightIndex) / 2.0;
        } else {
            median = leftIndex;
        }

        return new double[]{min, max, mean, median, modeIndex};
    }
}