import java.util.*;

class Solution {
    public int[] deckRevealedIncreasing(int[] deck) {
        Arrays.sort(deck);
        int n = deck.length;
        Deque<Integer> dq = new ArrayDeque<>();

        for (int i = 0; i < n; i++) {
            dq.addFirst(deck[i]);
            if (dq.size() > 1) {
                dq.addFirst(dq.removeLast());
            }
        }

        int[] result = new int[n];
        for (int i = 0; i < n; i++) {
            result[i] = dq.removeFirst();
        }

        return result;
    }
}