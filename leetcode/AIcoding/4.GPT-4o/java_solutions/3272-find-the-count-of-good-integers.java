class Solution {
    public int countGoodIntegers(int low, int high) {
        int count = 0;
        for (int i = low; i <= high; i++) {
            if (isGoodInteger(i)) {
                count++;
            }
        }
        return count;
    }

    private boolean isGoodInteger(int num) {
        String str = Integer.toString(num);
        char firstChar = str.charAt(0);
        for (char c : str.toCharArray()) {
            if (c != firstChar) {
                return false;
            }
        }
        return true;
    }
}