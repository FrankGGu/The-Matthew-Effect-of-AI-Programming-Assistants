class Solution {
    public boolean areNumbersAscending(String s) {
        int previousNumber = -1;
        String[] tokens = s.split(" ");

        for (String token : tokens) {
            try {
                int currentNumber = Integer.parseInt(token);
                if (currentNumber <= previousNumber) {
                    return false;
                }
                previousNumber = currentNumber;
            } catch (NumberFormatException e) {
                // Token is not a number, ignore it
            }
        }
        return true;
    }
}