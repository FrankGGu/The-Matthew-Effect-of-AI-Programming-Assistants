class Solution {
    public int numberOfBeams(String[] bank) {
        int prevCount = 0;
        int totalBeams = 0;

        for (String row : bank) {
            int currentCount = countDevices(row);
            if (currentCount > 0) {
                totalBeams += prevCount * currentCount;
                prevCount = currentCount;
            }
        }

        return totalBeams;
    }

    private int countDevices(String row) {
        int count = 0;
        for (char c : row.toCharArray()) {
            if (c == '1') {
                count++;
            }
        }
        return count;
    }
}