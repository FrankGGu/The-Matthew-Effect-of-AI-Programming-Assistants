public class Solution {

import java.util.*;

public class Solution {
    public int[] sampleStats(int[] count, int[] sum) {
        int[] result = new int[5];
        double mean = 0.0;
        int mode = 0;
        int maxCount = 0;
        double median = 0.0;
        int total = 0;
        List<Double> values = new ArrayList<>();

        for (int i = 0; i < count.length; i++) {
            if (count[i] > 0) {
                total += count[i];
                values.add((double) i);
                values.add((double) i);
                for (int j = 1; j < count[i]; j++) {
                    values.add((double) i);
                }
            }
        }

        if (total == 0) {
            return result;
        }

        for (int i = 0; i < count.length; i++) {
            if (count[i] > 0) {
                mean += (double) i * count[i];
            }
        }
        mean /= total;
        result[0] = (int) Math.round(mean);

        for (int i = 0; i < count.length; i++) {
            if (count[i] > maxCount) {
                maxCount = count[i];
                mode = i;
            }
        }
        result[1] = mode;

        Collections.sort(values);
        if (total % 2 == 1) {
            median = values.get(total / 2);
        } else {
            median = (values.get(total / 2 - 1) + values.get(total / 2)) / 2.0;
        }
        result[2] = (int) Math.round(median);

        double variance = 0.0;
        for (int i = 0; i < count.length; i++) {
            if (count[i] > 0) {
                variance += (double) i * i * count[i];
            }
        }
        variance /= total;
        variance -= mean * mean;
        result[3] = (int) Math.round(Math.sqrt(variance));

        result[4] = total;

        return result;
    }
}
}