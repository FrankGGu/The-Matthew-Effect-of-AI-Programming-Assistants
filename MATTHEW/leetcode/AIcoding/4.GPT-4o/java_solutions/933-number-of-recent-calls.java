import java.util.LinkedList;

class RecentCounter {
    private LinkedList<Integer> calls;

    public RecentCounter() {
        calls = new LinkedList<>();
    }

    public int ping(int t) {
        calls.add(t);
        while (calls.getFirst() < t - 3000) {
            calls.removeFirst();
        }
        return calls.size();
    }
}