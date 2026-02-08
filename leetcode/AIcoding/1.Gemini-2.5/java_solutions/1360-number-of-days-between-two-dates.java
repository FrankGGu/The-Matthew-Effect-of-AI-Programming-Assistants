class Solution {
    private int[] daysInMonth = {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

    private boolean isLeap(int year) {
        return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
    }

    private int countDaysFromEpoch(String dateStr) {
        String[] parts = dateStr.split("-");
        int year = Integer.parseInt(parts[0]);
        int month = Integer.parseInt(parts[1]);
        int day = Integer.parseInt(parts[2]);

        int totalDays = 0;

        // Calculate days from 1970-01-01 to the given date
        for (int y = 1970; y < year; y++) {
            totalDays += 365;
            if (isLeap(y)) {
                totalDays += 1;
            }
        }

        // Add days for full months passed in the current year
        for (int m = 1; m < month; m++) {
            totalDays += daysInMonth[m];
            if (m == 2 && isLeap(year)) { // February in a leap year
                totalDays += 1;
            }
        }

        // Add the day of the month
        totalDays += day;

        return totalDays;
    }

    public int daysBetweenDates(String date1, String date2) {
        int days1 = countDaysFromEpoch(date1);
        int days2 = countDaysFromEpoch(date2);
        return Math.abs(days1 - days2);
    }
}