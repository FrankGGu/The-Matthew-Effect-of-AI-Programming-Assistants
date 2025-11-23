class Solution {
    public String sortVowels(String s) {
        Set<Character> vowels = new HashSet<>(Arrays.asList('a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U'));
        List<Character> vowelList = new ArrayList<>();
        char[] chars = s.toCharArray();

        for (char c : chars) {
            if (vowels.contains(c)) {
                vowelList.add(c);
            }
        }

        Collections.sort(vowelList);

        int index = 0;
        for (int i = 0; i < chars.length; i++) {
            if (vowels.contains(chars[i])) {
                chars[i] = vowelList.get(index++);
            }
        }

        return new String(chars);
    }
}