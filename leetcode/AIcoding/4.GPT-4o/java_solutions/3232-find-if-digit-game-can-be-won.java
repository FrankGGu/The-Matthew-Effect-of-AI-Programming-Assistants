class Solution {
    public boolean dimSumGame(int num) {
        int count = 0;
        while (num > 0) {
            count += num % 10;
            num /= 10;
        }
        return count % 2 == 1;
    }
}