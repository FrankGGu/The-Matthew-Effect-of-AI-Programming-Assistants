class Solution {
    public int largestVariance(String s) {
        int n = s.length();
        int[] freq = new int[26];
        for (char c : s.toCharArray()) {
            freq[c - 'a']++;
        }

        int maxVariance = 0;
        for (int major = 0; major < 26; major++) {
            for (int minor = 0; minor < 26; minor++) {
                if (major == minor || freq[major] == 0 || freq[minor] == 0) {
                    continue;
                }

                char majorChar = (char) ('a' + major);
                char minorChar = (char) ('a' + minor);

                int majorCount = 0;
                int minorCount = 0;
                int remainingMajor = freq[major];

                for (int i = 0; i < n; i++) {
                    char c = s.charAt(i);

                    if (c == majorChar) {
                        majorCount++;
                        remainingMajor--;
                    } else if (c == minorChar) {
                        minorCount++;
                    }

                    if (minorCount > 0) {
                        maxVariance = Math.max(maxVariance, minorCount - majorCount);
                    } else if (remainingMajor > 0) {
                        majorCount = 0;
                    } else {
                        majorCount = 0;
                        minorCount = 0;
                    }

                    if (majorCount > minorCount && remainingMajor > 0) {
                        majorCount = 0;
                        minorCount = 0;
                    }
                }
            }
        }

        return maxVariance;
    }
}