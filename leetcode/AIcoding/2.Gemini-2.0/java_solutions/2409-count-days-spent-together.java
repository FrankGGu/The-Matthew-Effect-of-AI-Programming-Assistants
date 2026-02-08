class Solution {
    public int countDaysTogether(String arriveAlice, String leaveAlice, String arriveBob, String leaveBob) {
        int[] days = {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
        for (int i = 1; i <= 12; i++) {
            days[i] += days[i - 1];
        }

        int aliceStart = days[Integer.parseInt(arriveAlice.substring(0, 2)) - 1] + Integer.parseInt(arriveAlice.substring(3, 5));
        int aliceEnd = days[Integer.parseInt(leaveAlice.substring(0, 2)) - 1] + Integer.parseInt(leaveAlice.substring(3, 5));
        int bobStart = days[Integer.parseInt(arriveBob.substring(0, 2)) - 1] + Integer.parseInt(arriveBob.substring(3, 5));
        int bobEnd = days[Integer.parseInt(leaveBob.substring(0, 2)) - 1] + Integer.parseInt(leaveBob.substring(3, 5));

        int start = Math.max(aliceStart, bobStart);
        int end = Math.min(aliceEnd, bobEnd);

        return Math.max(0, end - start + 1);
    }
}