public class Solution {
    public String getEncryptedString(String s, int k) {
        StringBuilder encrypted = new StringBuilder();
        int n = s.length();
        for (int i = 0; i < n; i++) {
            encrypted.append(s.charAt((i + k) % n));
        }
        return encrypted.toString();
    }
}