import java.util.LinkedList;

class RecentCounter {
    private LinkedList<Integer> requests;

    public RecentCounter() {
        requests = new LinkedList<>();
    }

    public int ping(int t) {
        requests.add(t);
        while (requests.getFirst() < t - 3000) {
            requests.removeFirst();
        }
        return requests.size();
    }
}