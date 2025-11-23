class Solution {
    public int maxmiumScore(int[] cards, int cnt) {
        Arrays.sort(cards);
        int sum = 0;
        int lastOdd = -1, lastEven = -1;
        for (int i = cards.length - 1; i >= cards.length - cnt; i--) {
            sum += cards[i];
            if (cards[i] % 2 == 1) {
                lastOdd = cards[i];
            } else {
                lastEven = cards[i];
            }
        }
        if (sum % 2 == 0) {
            return sum;
        }
        int res = 0;
        for (int i = cards.length - cnt - 1; i >= 0; i--) {
            if (cards[i] % 2 == 1 && lastEven != -1) {
                res = Math.max(res, sum - lastEven + cards[i]);
            }
            if (cards[i] % 2 == 0 && lastOdd != -1) {
                res = Math.max(res, sum - lastOdd + cards[i]);
            }
        }
        return res;
    }
}