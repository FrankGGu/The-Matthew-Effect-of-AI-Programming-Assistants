class Solution {
    public String lastNonEmptyString(String s) {
        Map<Character, Integer> freq = new HashMap<>();
        for (char c : s.toCharArray()) {
            freq.put(c, freq.getOrDefault(c, 0) + 1);
        }

        int maxFreq = Collections.max(freq.values());

        Set<Character> maxChars = new HashSet<>();
        for (Map.Entry<Character, Integer> entry : freq.entrySet()) {
            if (entry.getValue() == maxFreq) {
                maxChars.add(entry.getKey());
            }
        }

        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            if (maxChars.contains(c) && freq.get(c) == maxFreq) {
                sb.append(c);
                freq.put(c, freq.get(c) - 1);
            }
        }

        return sb.toString();
    }
}