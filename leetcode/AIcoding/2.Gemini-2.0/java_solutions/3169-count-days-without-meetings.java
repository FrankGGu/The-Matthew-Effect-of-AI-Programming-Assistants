class Solution {
    public int countDaysWithoutMeetings(int[] meetings, int startDay) {
        int n = meetings.length;
        int maxDay = startDay;
        for (int i = 0; i < n; i++) {
            int requiredDay = ((maxDay + meetings[i] - 1) / meetings[i]) * meetings[i];
            maxDay = Math.max(maxDay + 1, requiredDay + 1);
        }
        return maxDay - startDay;
    }
}