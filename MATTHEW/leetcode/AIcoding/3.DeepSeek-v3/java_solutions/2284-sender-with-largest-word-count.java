class Solution {
    public String largestWordCount(String[] messages, String[] senders) {
        Map<String, Integer> map = new HashMap<>();
        int max = 0;
        for (int i = 0; i < messages.length; i++) {
            String sender = senders[i];
            String message = messages[i];
            int words = message.split(" ").length;
            map.put(sender, map.getOrDefault(sender, 0) + words);
            max = Math.max(max, map.get(sender));
        }
        List<String> candidates = new ArrayList<>();
        for (String sender : map.keySet()) {
            if (map.get(sender) == max) {
                candidates.add(sender);
            }
        }
        candidates.sort((a, b) -> b.compareTo(a));
        return candidates.get(0);
    }
}