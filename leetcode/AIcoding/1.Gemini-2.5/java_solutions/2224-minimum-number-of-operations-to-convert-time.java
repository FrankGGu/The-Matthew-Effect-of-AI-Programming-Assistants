class Solution {
    public int convertTime(String current, String correct) {
        String[] currentParts = current.split(":");
        int currentMinutes = Integer.parseInt(currentParts[0]) * 60 + Integer.parseInt(currentParts[1]);

        String[] correctParts = correct.split(":");
        int correctMinutes = Integer.parseInt(correctParts[0]) * 60 + Integer.parseInt(correctParts[1]);

        int diff = correctMinutes - currentMinutes;
        int operations = 0;

        operations += diff / 60;
        diff %= 60;

        operations += diff / 15;
        diff %= 15;

        operations += diff / 5;
        diff %= 5;

        operations += diff;

        return operations;
    }
}