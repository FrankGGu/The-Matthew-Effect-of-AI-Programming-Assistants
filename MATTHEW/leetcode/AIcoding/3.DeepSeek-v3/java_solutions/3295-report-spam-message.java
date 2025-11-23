class Solution {
    public int[] report(int[][] messages, int[][] spam) {
        Map<Integer, Integer> messageCount = new HashMap<>();
        Map<Integer, Set<Integer>> userMessages = new HashMap<>();

        for (int[] message : messages) {
            int sender = message[0];
            int recipient = message[1];
            messageCount.put(recipient, messageCount.getOrDefault(recipient, 0) + 1);
            userMessages.computeIfAbsent(recipient, k -> new HashSet<>()).add(sender);
        }

        List<Integer> result = new ArrayList<>();
        for (int[] s : spam) {
            int recipient = s[0];
            int threshold = s[1];
            int count = messageCount.getOrDefault(recipient, 0);
            int uniqueSenders = userMessages.getOrDefault(recipient, new HashSet<>()).size();
            if (count >= threshold && uniqueSenders * 5 < count) {
                result.add(recipient);
            }
        }

        return result.stream().mapToInt(i -> i).toArray();
    }
}