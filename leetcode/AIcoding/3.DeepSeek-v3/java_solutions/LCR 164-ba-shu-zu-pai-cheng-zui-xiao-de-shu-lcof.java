class Solution {
    public String crackPassword(int[] password) {
        String[] strs = new String[password.length];
        for (int i = 0; i < password.length; i++) {
            strs[i] = String.valueOf(password[i]);
        }
        Arrays.sort(strs, (a, b) -> (a + b).compareTo(b + a));
        StringBuilder sb = new StringBuilder();
        for (String s : strs) {
            sb.append(s);
        }
        return sb.toString();
    }
}