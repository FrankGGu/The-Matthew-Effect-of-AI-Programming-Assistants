class Solution {
    public int daysBetweenDates(String date1, String date2) {
        return Math.abs(daysSince1971(date1) - daysSince1971(date2));
    }

    private int daysSince1971(String date) {
        int year = Integer.parseInt(date.substring(0, 4));
        int month = Integer.parseInt(date.substring(5, 7));
        int day = Integer.parseInt(date.substring(8, 10));

        int days = 0;
        for (int y = 1971; y < year; y++) {
            days += isLeapYear(y) ? 366 : 365;
        }

        int[] daysInMonth = {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
        if (isLeapYear(year)) {
            daysInMonth[2] = 29;
        }

        for (int m = 1; m < month; m++) {
            days += daysInMonth[m];
        }

        days += day;
        return days;
    }

    private boolean isLeapYear(int year) {
        return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
    }
}