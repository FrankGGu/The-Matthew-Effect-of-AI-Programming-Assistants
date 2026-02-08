import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

class Solution {
    private long combinations(int n, int r) {
        if (r < 0 || r > n) {
            return 0;
        }
        if (r == 0 || r == n) {
            return 1;
        }
        if (r > n / 2) {
            r = n - r;
        }
        long res = 1;
        for (int i = 0; i < r; i++) {
            res = res * (n - i) / (i + 1);
        }
        return res;
    }

    public int countKSubsequencesWithMaxBeauty(String s, int k) {
        int[] counts = new int[26];
        for (char c : s.toCharArray()) {
            counts[c - 'a']++;
        }

        List<Integer> availableFrequencies = new ArrayList<>();
        for (int count : counts) {
            if (count > 0) {
                availableFrequencies.add(count);
            }
        }

        if (availableFrequencies.size() < k) {
            return 0;
        }

        Collections.sort(availableFrequencies, Collections.reverseOrder());

        int minFreqInTopK = availableFrequencies.get(k - 1);

        int countGreater = 0;
        int countEqual = 0;

        for (int freq : availableFrequencies) {
            if (freq > minFreqInTopK) {
                countGreater++;
            } else if (freq == minFreqInTopK) {
                countEqual++;
            } else {
                break; 
            }
        }

        int neededFromEqual = k - countGreater;

        long result = combinations(countEqual, neededFromEqual);
        return (int) result;
    }
}