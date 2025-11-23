class Solution {
    public int findTheLongestSubstring(String s) {
        int[] index = new int[32];
        Arrays.fill(index, -1);
        index[0] = 0;
        int maxLength = 0, mask = 0;

        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            switch (c) {
                case 'a': mask ^= 1 << 0; break;
                case 'e': mask ^= 1 << 1; break;
                case 'i': mask ^= 1 << 2; break;
                case 'o': mask ^= 1 << 3; break;
                case 'u': mask ^= 1 << 4; break;
            }
            if (index[mask] == -1) {
                index[mask] = i + 1;
            } else {
                maxLength = Math.max(maxLength, i + 1 - index[mask]);
            }
        }

        return maxLength;
    }
}