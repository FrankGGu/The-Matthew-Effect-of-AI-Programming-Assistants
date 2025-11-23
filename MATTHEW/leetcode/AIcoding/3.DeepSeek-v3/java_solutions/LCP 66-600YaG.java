class Solution {
    public int minBooths(String[] demand) {
        int[] maxCount = new int[26];
        for (String day : demand) {
            int[] dayCount = new int[26];
            for (char c : day.toCharArray()) {
                dayCount[c - 'a']++;
            }
            for (int i = 0; i < 26; i++) {
                if (dayCount[i] > maxCount[i]) {
                    maxCount[i] = dayCount[i];
                }
            }
        }
        int total = 0;
        for (int count : maxCount) {
            total += count;
        }
        return total;
    }
}