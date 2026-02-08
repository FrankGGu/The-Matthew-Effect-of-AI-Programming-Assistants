class Solution {
    public int maxProduct(String[] words) {
        if (words == null || words.length == 0) {
            return 0;
        }

        int n = words.length;
        int[] masks = new int[n];
        int[] lengths = new int[n];

        for (int i = 0; i < n; i++) {
            String word = words[i];
            lengths[i] = word.length();
            int mask = 0;
            for (char c : word.toCharArray()) {
                mask |= (1 << (c - 'a'));
            }
            masks[i] = mask;
        }

        int maxProduct = 0;
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                if ((masks[i] & masks[j]) == 0) {
                    maxProduct = Math.max(maxProduct, lengths[i] * lengths[j]);
                }
            }
        }

        return maxProduct;
    }
}