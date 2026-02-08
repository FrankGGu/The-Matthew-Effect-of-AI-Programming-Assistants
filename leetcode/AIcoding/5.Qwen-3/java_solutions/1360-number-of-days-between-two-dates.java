public class Solution {
    public int daysBetweenDates(String date1, String date2) {
        int year1 = Integer.parseInt(date1.substring(0, 4));
        int month1 = Integer.parseInt(date1.substring(5, 7));
        int day1 = Integer.parseInt(date1.substring(8, 10));

        int year2 = Integer.parseInt(date2.substring(0, 4));
        int month2 = Integer.parseInt(date2.substring(5, 7));
        int day2 = Integer.parseInt(date2.substring(8, 10));

        return Math.abs(daysSinceEpoch(year1, month1, day1) - daysSinceEpoch(year2, month2, day2));
    }

    private int daysSinceEpoch(int year, int month, int day) {
        int[] months = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
        int days = 0;

        for (int y = 1970; y < year; y++) {
            days += isLeapYear(y) ? 366 : 365;
        }

        for (int m = 1; m < month; m++) {
            days += months[m - 1];
            if (m == 2 && isLeapYear(year)) {
                days++;
            }
        }

        days += day - 1;
        return days;
    }

    private boolean isLeapYear(int year) {
        return year % 4 == 0 && (year % 100 != 0 || year % 400 == 0);
    }
}