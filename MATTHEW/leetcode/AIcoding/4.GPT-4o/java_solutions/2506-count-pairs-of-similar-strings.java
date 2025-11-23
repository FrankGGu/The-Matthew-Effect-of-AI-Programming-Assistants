import java.util.HashMap;

class Solution {
    public int similarPairs(String[] words) {
        HashMap<String, Integer> map = new HashMap<>();
        int count = 0;

        for (String word : words) {
            char[] chars = word.toCharArray();
            Arrays.sort(chars);
            String sortedWord = new String(chars);
            count += map.getOrDefault(sortedWord, 0);
            map.put(sortedWord, map.getOrDefault(sortedWord, 0) + 1);
        }

        return count;
    }
}