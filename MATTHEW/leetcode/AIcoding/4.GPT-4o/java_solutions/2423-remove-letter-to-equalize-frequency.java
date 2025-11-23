class Solution {
    public boolean equalFrequency(String word) {
        int[] freq = new int[26];
        for (char c : word.toCharArray()) {
            freq[c - 'a']++;
        }

        int[] count = new int[word.length() + 1];
        for (int f : freq) {
            if (f > 0) {
                count[f]++;
            }
        }

        for (int i = 1; i <= word.length(); i++) {
            if (count[i] > 0) {
                count[i]--;
                if (count[i] == 0) {
                    int totalFreq = 0;
                    for (int j = 1; j <= word.length(); j++) {
                        if (count[j] > 0) {
                            totalFreq++;
                        }
                    }
                    if (totalFreq == 1 || (totalFreq == 2 && (i == 1 || (count[i - 1] > 0)))) {
                        return true;
                    }
                }
                count[i]++;
            }
        }
        return false;
    }
}