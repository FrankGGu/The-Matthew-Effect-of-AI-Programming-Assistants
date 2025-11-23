class Solution {
    public String minimizeStringValue(String s) {
        int[] freq = new int[26];
        char[] chars = s.toCharArray();
        List<Integer> positions = new ArrayList<>();

        for (int i = 0; i < chars.length; i++) {
            if (chars[i] != '?') {
                freq[chars[i] - 'a']++;
            } else {
                positions.add(i);
            }
        }

        List<Character> toInsert = new ArrayList<>();
        for (int i = 0; i < positions.size(); i++) {
            int minFreq = Integer.MAX_VALUE;
            char c = 'a';
            for (int j = 0; j < 26; j++) {
                if (freq[j] < minFreq) {
                    minFreq = freq[j];
                    c = (char) ('a' + j);
                }
            }
            toInsert.add(c);
            freq[c - 'a']++;
        }

        Collections.sort(toInsert);
        for (int i = 0; i < positions.size(); i++) {
            chars[positions.get(i)] = toInsert.get(i);
        }

        return new String(chars);
    }
}