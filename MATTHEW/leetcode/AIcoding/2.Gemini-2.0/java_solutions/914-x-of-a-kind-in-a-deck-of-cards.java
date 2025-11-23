class Solution {
    public boolean hasGroupsSizeX(int[] deck) {
        if (deck == null || deck.length < 2) {
            return false;
        }

        Map<Integer, Integer> counts = new HashMap<>();
        for (int card : deck) {
            counts.put(card, counts.getOrDefault(card, 0) + 1);
        }

        int gcd = 0;
        for (int count : counts.values()) {
            gcd = gcd(gcd, count);
        }

        return gcd >= 2;
    }

    private int gcd(int a, int b) {
        while (b != 0) {
            int temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }
}