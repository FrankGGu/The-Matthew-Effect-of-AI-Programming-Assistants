public class Solution {
    public int numJewelsInStones(String jewels, String stones) {
        boolean[] isJewel = new boolean[58];
        for (int i = 0; i < jewels.length(); i++) {
            isJewel[jewels.charAt(i) - 'A'] = true;
        }
        int count = 0;
        for (int i = 0; i < stones.length(); i++) {
            if (isJewel[stones.charAt(i) - 'A']) {
                count++;
            }
        }
        return count;
    }
}