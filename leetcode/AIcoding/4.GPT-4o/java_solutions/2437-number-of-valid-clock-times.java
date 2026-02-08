class Solution {
    public int numberOfValidClockTimes(String time) {
        int count = 0;
        for (int h = 0; h < 24; h++) {
            for (int m = 0; m < 60; m++) {
                String hour = String.format("%02d", h);
                String minute = String.format("%02d", m);
                String validTime = hour + ":" + minute;
                if (isValidTime(validTime, time)) {
                    count++;
                }
            }
        }
        return count;
    }

    private boolean isValidTime(String validTime, String time) {
        for (int i = 0; i < 5; i++) {
            if (time.charAt(i) != '?' && time.charAt(i) != validTime.charAt(i)) {
                return false;
            }
        }
        return true;
    }
}