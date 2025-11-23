class Solution {
    public int countDaysTogether(String arriveAlice, String leaveAlice, String arriveBob, String leaveBob) {
        int[] daysInMonth = {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
        int totalDays = 0;

        for (int i = 1; i < 12; i++) {
            daysInMonth[i] += daysInMonth[i - 1];
        }

        int arriveAliceDays = getDays(arriveAlice);
        int leaveAliceDays = getDays(leaveAlice);
        int arriveBobDays = getDays(arriveBob);
        int leaveBobDays = getDays(leaveBob);

        int start = Math.max(arriveAliceDays, arriveBobDays);
        int end = Math.min(leaveAliceDays, leaveBobDays);

        return Math.max(0, end - start + 1);
    }

    private int getDays(String date) {
        String[] parts = date.split("-");
        int month = Integer.parseInt(parts[0]);
        int day = Integer.parseInt(parts[1]);

        return (month == 1 ? 0 : monthDays(month - 1)) + day;
    }

    private int monthDays(int month) {
        int[] daysInMonth = {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
        int total = 0;
        for (int i = 1; i <= month; i++) {
            total += daysInMonth[i];
        }
        return total;
    }
}