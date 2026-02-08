class Solution {
    public String repeatLimitedString(String s, int repeatLimit) {
        int[] count = new int[26];
        for (char c : s.toCharArray()) {
            count[c - 'a']++;
        }

        StringBuilder sb = new StringBuilder();
        for (int i = 25; i >= 0; i--) {
            while (count[i] > 0) {
                int repeat = Math.min(repeatLimit, count[i]);
                for (int j = 0; j < repeat; j++) {
                    sb.append((char) ('a' + i));
                }
                count[i] -= repeat;

                if (count[i] > 0) {
                    int j = i - 1;
                    while (j >= 0 && count[j] == 0) {
                        j--;
                    }
                    if (j < 0) {
                        break;
                    }
                    sb.append((char) ('a' + j));
                    count[j]--;
                }
            }
        }

        return sb.toString();
    }
}