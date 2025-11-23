class Solution {
    public char findKthCharacter(String s, int k) {
        StringBuilder sb = new StringBuilder(s);
        while (sb.length() < k) {
            StringBuilder temp = new StringBuilder();
            for (int i = 0; i < sb.length(); i++) {
                char c = sb.charAt(i);
                temp.append(c);
                if (c == 'z') {
                    temp.append('a');
                } else {
                    temp.append((char)(c + 1));
                }
            }
            sb = temp;
        }
        return sb.charAt(k - 1);
    }
}