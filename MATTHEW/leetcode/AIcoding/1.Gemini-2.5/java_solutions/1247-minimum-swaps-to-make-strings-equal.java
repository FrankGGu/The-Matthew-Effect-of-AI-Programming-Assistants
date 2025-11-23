class Solution {
    public int minimumSwaps(String s1, String s2) {
        int count_xy = 0; // s1 has 'x', s2 has 'y' at this position
        int count_yx = 0; // s1 has 'y', s2 has 'x' at this position

        for (int i = 0; i < s1.length(); i++) {
            char c1 = s1.charAt(i);
            char c2 = s2.charAt(i);

            if (c1 == c2) {
                continue;
            }

            if (c1 == 'x' && c2 == 'y') {
                count_xy++;
            } else { // c1 == 'y' && c2 == 'x'
                count_yx++;
            }
        }

        if ((count_xy + count_yx) % 2 != 0) {
            return -1;
        }

        int swaps = 0;

        swaps += count_xy / 2;
        swaps += count_yx / 2;

        if (count_xy % 2 == 1) { 
            swaps += 2;
        }

        return swaps;
    }
}