class Solution {
    public int similarPairs(String[] words) {
        int n = words.length;
        int[] masks = new int[n];

        for (int i = 0; i < n; i++) {
            int mask = 0;
            for (char c : words[i].toCharArray()) {
                mask |= (1 << (c - 'a'));
            }
            masks[i] = mask;
        }

        int count = 0;
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                if (masks[i] == masks[j]) {
                    count++;
                }
            }
        }
        return count;
    }
}