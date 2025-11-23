class Solution {
    public int minNumber(String target) {
        int countA = 0;
        int countB = 0;
        int result = 0;
        for (char c : target.toCharArray()) {
            if (c == 'A') {
                if (countB > 0) {
                    countB--;
                }
                countA++;
            } else {
                if (countA > 0) {
                    countA--;
                }
                countB++;
            }
        }
        return countA + countB;
    }
}