class Solution {
    public List<String> removeAnagrams(String[] words) {
        List<String> result = new ArrayList<>();
        if (words == null || words.length == 0) {
            return result;
        }
        String prev = "";
        for (String word : words) {
            char[] chars = word.toCharArray();
            Arrays.sort(chars);
            String current = new String(chars);
            if (!current.equals(prev)) {
                result.add(word);
                prev = current;
            }
        }
        return result;
    }
}