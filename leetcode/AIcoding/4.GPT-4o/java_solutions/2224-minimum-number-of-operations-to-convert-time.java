class Solution {
    public int convertTime(String current, String correct) {
        int currentMinutes = convertToMinutes(current);
        int correctMinutes = convertToMinutes(correct);
        int diff = correctMinutes - currentMinutes;

        int[] operations = {60, 15, 5, 1};
        int count = 0;

        for (int op : operations) {
            count += diff / op;
            diff %= op;
        }

        return count;
    }

    private int convertToMinutes(String time) {
        String[] parts = time.split(":");
        return Integer.parseInt(parts[0]) * 60 + Integer.parseInt(parts[1]);
    }
}