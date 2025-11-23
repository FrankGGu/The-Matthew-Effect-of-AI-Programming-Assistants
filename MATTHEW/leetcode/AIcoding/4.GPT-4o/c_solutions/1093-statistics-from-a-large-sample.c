double[] sampleStats(int[] count) {
    double min = 256, max = -1, sum = 0, total = 0;
    int mode = 0, maxCount = 0;

    for (int i = 0; i < 256; i++) {
        if (count[i] > 0) {
            if (min == 256) min = i;
            if (max == -1) max = i;
            sum += i * count[i];
            total += count[i];
            if (count[i] > maxCount) {
                maxCount = count[i];
                mode = i;
            }
        }
    }

    double mean = sum / total;
    double[] result = new double[5];
    result[0] = min;
    result[1] = max;
    result[2] = mean;
    result[3] = mode;
    result[4] = total;

    return result;
}