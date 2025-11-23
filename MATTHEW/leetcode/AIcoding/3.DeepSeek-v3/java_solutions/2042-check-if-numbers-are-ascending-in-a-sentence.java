class Solution {
    public boolean areNumbersAscending(String s) {
        int prev = -1;
        String[] tokens = s.split(" ");
        for (String token : tokens) {
            try {
                int num = Integer.parseInt(token);
                if (num <= prev) {
                    return false;
                }
                prev = num;
            } catch (NumberFormatException e) {
                continue;
            }
        }
        return true;
    }
}