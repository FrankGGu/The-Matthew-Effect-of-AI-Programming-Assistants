class Solution {
    public int numberOfBeams(String[] bank) {
        int totalBeams = 0;
        int prevCount = 0;

        for (String row : bank) {
            int currentCount = 0;
            for (char c : row.toCharArray()) {
                if (c == '1') {
                    currentCount++;
                }
            }
            if (currentCount > 0) {
                totalBeams += prevCount * currentCount;
                prevCount = currentCount;
            }
        }

        return totalBeams;
    }
}