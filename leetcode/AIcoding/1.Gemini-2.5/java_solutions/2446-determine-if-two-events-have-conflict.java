class Solution {
    private int parseTime(String timeStr) {
        String[] parts = timeStr.split(":");
        int hours = Integer.parseInt(parts[0]);
        int minutes = Integer.parseInt(parts[1]);
        return hours * 60 + minutes;
    }

    public boolean haveConflict(String[] event1, String[] event2) {
        int start1 = parseTime(event1[0]);
        int end1 = parseTime(event1[1]);
        int start2 = parseTime(event2[0]);
        int end2 = parseTime(event2[1]);

        return start1 <= end2 && start2 <= end1;
    }
}