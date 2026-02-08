class Solution {
    public boolean isAcronym(String[] words, String s) {
        StringBuilder acronym = new StringBuilder();
        for (String word : words) {
            acronym.append(word.charAt(0));
        }
        return acronym.toString().equals(s);
    }
}