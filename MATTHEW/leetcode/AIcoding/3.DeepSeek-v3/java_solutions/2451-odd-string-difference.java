class Solution {
    public String oddString(String[] words) {
        Map<String, List<String>> map = new HashMap<>();

        for (String word : words) {
            String key = getKey(word);
            if (!map.containsKey(key)) {
                map.put(key, new ArrayList<>());
            }
            map.get(key).add(word);
        }

        for (List<String> list : map.values()) {
            if (list.size() == 1) {
                return list.get(0);
            }
        }

        return "";
    }

    private String getKey(String word) {
        StringBuilder sb = new StringBuilder();
        for (int i = 1; i < word.length(); i++) {
            int diff = word.charAt(i) - word.charAt(i - 1);
            sb.append(diff).append(",");
        }
        return sb.toString();
    }
}