class Solution {
    public String getEncryptedString(String s, int k) {
        StringBuilder encrypted = new StringBuilder();
        int n = s.length();
        for (int i = 0; i < n; i++) {
            int newIndex = (i + k) % n;
            encrypted.append(s.charAt(newIndex));
        }
        return encrypted.toString();
    }
}