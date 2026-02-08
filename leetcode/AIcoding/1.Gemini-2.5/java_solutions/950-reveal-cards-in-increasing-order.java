import java.util.Arrays;
import java.util.Deque;
import java.util.LinkedList;

class Solution {
    public int[] deckRevealedIncreasing(int[] deck) {
        int n = deck.length;
        Arrays.sort(deck);

        int[] result = new int[n];
        Deque<Integer> q = new LinkedList<>();

        for (int i = 0; i < n; i++) {
            q.add(i);
        }

        for (int card : deck) {
            result[q.poll()] = card;
            if (!q.isEmpty()) {
                q.add(q.poll());
            }
        }

        return result;
    }
}