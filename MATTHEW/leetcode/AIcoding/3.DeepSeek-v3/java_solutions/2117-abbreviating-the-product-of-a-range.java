class Solution {
    public String abbreviateProduct(int left, int right) {
        long suff = 1;
        double pref = 1.0;
        int zeros = 0;
        boolean large = false;

        for (int i = left; i <= right; i++) {
            pref *= i;
            suff *= i;

            while (pref >= 100000) {
                pref /= 10;
            }

            while (suff % 10 == 0) {
                suff /= 10;
                zeros++;
            }

            if (suff >= 10000000000L) {
                suff %= 10000000000L;
                large = true;
            }
        }

        if (!large) {
            return suff + "e" + zeros;
        } else {
            String s = Long.toString(suff);
            while (s.length() < 5) {
                s = "0" + s;
            }
            return (int)pref + "..." + s.substring(s.length() - 5) + "e" + zeros;
        }
    }
}