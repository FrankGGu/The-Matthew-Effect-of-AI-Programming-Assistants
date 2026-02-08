class Solution {
    public int largestVariance(String s) {
        int[] freq = new int[26];
        for (char c : s.toCharArray()) {
            freq[c - 'a']++;
        }
        int maxVariance = 0;
        for (char a = 'a'; a <= 'z'; a++) {
            for (char b = 'a'; b <= 'z'; b++) {
                if (a == b || freq[a - 'a'] == 0 || freq[b - 'a'] == 0) {
                    continue;
                }
                int variance = 0;
                boolean hasB = false;
                boolean startsWithB = false;
                int countA = 0;
                int countB = 0;
                for (char c : s.toCharArray()) {
                    if (c == a) {
                        countA++;
                    } else if (c == b) {
                        countB++;
                    }
                    if (countB > 0) {
                        variance = Math.max(variance, countA - countB);
                    } else if (startsWithB) {
                        variance = Math.max(variance, countA - 1);
                    }
                    if (countB > countA) {
                        countA = 0;
                        countB = 0;
                        startsWithB = true;
                    }
                }
                maxVariance = Math.max(maxVariance, variance);
            }
        }
        return maxVariance;
    }
}