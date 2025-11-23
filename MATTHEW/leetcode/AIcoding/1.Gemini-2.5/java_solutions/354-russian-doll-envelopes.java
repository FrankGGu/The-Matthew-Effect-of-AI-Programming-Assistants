import java.util.Arrays;
import java.util.Comparator;
import java.util.ArrayList;
import java.util.Collections;

class Solution {
    public int maxEnvelopes(int[][] envelopes) {
        if (envelopes == null || envelopes.length == 0) {
            return 0;
        }

        Arrays.sort(envelopes, new Comparator<int[]>() {
            @Override
            public int compare(int[] a, int[] b) {
                if (a[0] != b[0]) {
                    return a[0] - b[0];
                } else {
                    return b[1] - a[1];
                }
            }
        });

        ArrayList<Integer> tails = new ArrayList<>();

        for (int[] envelope : envelopes) {
            int height = envelope[1];

            int i = Collections.binarySearch(tails, height);

            if (i < 0) {
                i = -i - 1;
            }

            if (i == tails.size()) {
                tails.add(height);
            } else {
                tails.set(i, height);
            }
        }

        return tails.size();
    }
}