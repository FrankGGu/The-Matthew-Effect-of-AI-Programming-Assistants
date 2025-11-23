class Solution {
    public int countTime(String time) {
        int count = 0;
        for (int h = 0; h < 24; h++) {
            String hourStr = String.format("%02d", h);
            boolean hourMatch = true;
            if (time.charAt(0) != '?' && time.charAt(0) != hourStr.charAt(0)) {
                hourMatch = false;
            }
            if (time.charAt(1) != '?' && time.charAt(1) != hourStr.charAt(1)) {
                hourMatch = false;
            }

            if (hourMatch) {
                for (int m = 0; m < 60; m++) {
                    String minuteStr = String.format("%02d", m);
                    boolean minuteMatch = true;
                    if (time.charAt(3) != '?' && time.charAt(3) != minuteStr.charAt(0)) {
                        minuteMatch = false;
                    }
                    if (time.charAt(4) != '?' && time.charAt(4) != minuteStr.charAt(1)) {
                        minuteMatch = false;
                    }

                    if (minuteMatch) {
                        count++;
                    }
                }
            }
        }
        return count;
    }
}