class Solution {
    public int countDaysTogether(String arriveAlice, String leaveAlice, String arriveBob, String leaveBob) {
        int[] daysAlice = getDays(arriveAlice, leaveAlice);
        int[] daysBob = getDays(arriveBob, leaveBob);

        int start = Math.max(daysAlice[0], daysBob[0]);
        int end = Math.min(daysAlice[1], daysBob[1]);

        return Math.max(0, end - start + 1);
    }

    private int[] getDays(String arrive, String leave) {
        int start = getDayOfYear(arrive);
        int end = getDayOfYear(leave);
        return new int[]{start, end};
    }

    private int getDayOfYear(String date) {
        String[] parts = date.split("-");
        int month = Integer.parseInt(parts[1]);
        int day = Integer.parseInt(parts[2]);
        int[] daysInMonth = {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
        int dayOfYear = day;

        for (int i = 1; i < month; i++) {
            dayOfYear += daysInMonth[i];
        }

        return dayOfYear;
    }
}