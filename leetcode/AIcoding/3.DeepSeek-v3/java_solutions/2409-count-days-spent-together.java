class Solution {
    public int countDaysTogether(String arriveAlice, String leaveAlice, String arriveBob, String leaveBob) {
        int[] daysInMonth = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

        int aliceArriveMonth = Integer.parseInt(arriveAlice.substring(0, 2));
        int aliceArriveDay = Integer.parseInt(arriveAlice.substring(3));
        int aliceLeaveMonth = Integer.parseInt(leaveAlice.substring(0, 2));
        int aliceLeaveDay = Integer.parseInt(leaveAlice.substring(3));

        int bobArriveMonth = Integer.parseInt(arriveBob.substring(0, 2));
        int bobArriveDay = Integer.parseInt(arriveBob.substring(3));
        int bobLeaveMonth = Integer.parseInt(leaveBob.substring(0, 2));
        int bobLeaveDay = Integer.parseInt(leaveBob.substring(3));

        int aliceArriveTotal = calculateDays(aliceArriveMonth, aliceArriveDay, daysInMonth);
        int aliceLeaveTotal = calculateDays(aliceLeaveMonth, aliceLeaveDay, daysInMonth);
        int bobArriveTotal = calculateDays(bobArriveMonth, bobArriveDay, daysInMonth);
        int bobLeaveTotal = calculateDays(bobLeaveMonth, bobLeaveDay, daysInMonth);

        int start = Math.max(aliceArriveTotal, bobArriveTotal);
        int end = Math.min(aliceLeaveTotal, bobLeaveTotal);

        return Math.max(0, end - start + 1);
    }

    private int calculateDays(int month, int day, int[] daysInMonth) {
        int total = 0;
        for (int i = 0; i < month - 1; i++) {
            total += daysInMonth[i];
        }
        total += day;
        return total;
    }
}