class Solution {
    public String dayOfTheWeek(int day, int month, int year) {
        String[] days = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"};
        int[] months = {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

        int totalDays = 0;

        for (int i = 1971; i < year; i++) {
            if ((i % 4 == 0 && i % 100 != 0) || (i % 400 == 0)) {
                totalDays += 366;
            } else {
                totalDays += 365;
            }
        }

        if ((year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)) {
            months[2] = 29;
        }

        for (int i = 1; i < month; i++) {
            totalDays += months[i];
        }

        totalDays += day;

        return days[(totalDays + 4) % 7];
    }
}