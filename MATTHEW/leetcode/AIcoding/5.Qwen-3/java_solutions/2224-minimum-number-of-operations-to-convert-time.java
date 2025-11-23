public class Solution {

class Solution {
    public int convertTime(String current, String correct) {
        int currentMin = convertToMinutes(current);
        int correctMin = convertToMinutes(correct);

        int diff = correctMin - currentMin;
        int operations = 0;

        int[] denominations = {60, 15, 5, 1};

        for (int denom : denominations) {
            if (diff >= denom) {
                operations += diff / denom;
                diff %= denom;
            }
        }

        return operations;
    }

    private int convertToMinutes(String time) {
        String[] parts = time.split(":");
        int hours = Integer.parseInt(parts[0]);
        int minutes = Integer.parseInt(parts[1]);
        return hours * 60 + minutes;
    }
}
}