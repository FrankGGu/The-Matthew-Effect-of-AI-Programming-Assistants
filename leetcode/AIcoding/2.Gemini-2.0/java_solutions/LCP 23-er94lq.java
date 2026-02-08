class Solution {
    public int[] deckRevealedIncreasing(int[] deck) {
        int n = deck.length;
        int[] result = new int[n];
        java.util.Arrays.sort(deck);
        java.util.Queue<Integer> queue = new java.util.LinkedList<>();
        for (int i = 0; i < n; i++) {
            queue.offer(i);
        }

        for (int i = 0; i < n; i++) {
            result[queue.poll()] = deck[i];
            if (!queue.isEmpty()) {
                queue.offer(queue.poll());
            }
        }

        return result;
    }
}