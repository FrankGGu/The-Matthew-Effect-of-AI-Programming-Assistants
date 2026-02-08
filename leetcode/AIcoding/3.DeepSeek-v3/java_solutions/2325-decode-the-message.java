class Solution {
    public String decodeMessage(String key, String message) {
        Map<Character, Character> map = new HashMap<>();
        char current = 'a';
        for (char c : key.toCharArray()) {
            if (c != ' ' && !map.containsKey(c)) {
                map.put(c, current);
                current++;
            }
        }
        StringBuilder sb = new StringBuilder();
        for (char c : message.toCharArray()) {
            if (c == ' ') {
                sb.append(' ');
            } else {
                sb.append(map.get(c));
            }
        }
        return sb.toString();
    }
}