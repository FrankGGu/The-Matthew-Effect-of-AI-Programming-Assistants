class Solution {

    private static final int[] DAYS_IN_MONTH = {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

    private int getDayOfYear(String date) {
        int month = Integer.parseInt(date.substring(0, 2));
        int day = Integer.parseInt(date.substring(3, 5));

        int dayOfYear = 0;
        for (int m = 1; m < month; m++) {
            dayOfYear += DAYS_IN_MONTH[m];
        }
        dayOfYear += day;
        return dayOfYear;
    }

    public int countDaysTogether(String aliceArrivalDate, String aliceDepartureDate, String bobArrivalDate, String bobDepartureDate) {
        int aliceArrival = getDayOfYear(aliceArrivalDate);
        int aliceDeparture = getDayOfYear(aliceDepartureDate);
        int bobArrival = getDayOfYear(bobArrivalDate);
        int bobDeparture = getDayOfYear(bobDepartureDate);

        int overlapStart = Math.max(aliceArrival, bobArrival);
        int overlapEnd = Math.min(aliceDeparture, bobDeparture);

        if (overlapStart <= overlapEnd) {
            return overlapEnd - overlapStart + 1;
        } else {
            return 0;
        }
    }
}