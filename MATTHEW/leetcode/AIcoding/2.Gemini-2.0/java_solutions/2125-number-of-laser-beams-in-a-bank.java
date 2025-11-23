class Solution {
    public int numberOfBeams(String[] bank) {
        int prevDevices = 0;
        int totalBeams = 0;
        for (String row : bank) {
            int currentDevices = 0;
            for (char c : row.toCharArray()) {
                if (c == '1') {
                    currentDevices++;
                }
            }
            if (currentDevices > 0) {
                totalBeams += prevDevices * currentDevices;
                prevDevices = currentDevices;
            }
        }
        return totalBeams;
    }
}