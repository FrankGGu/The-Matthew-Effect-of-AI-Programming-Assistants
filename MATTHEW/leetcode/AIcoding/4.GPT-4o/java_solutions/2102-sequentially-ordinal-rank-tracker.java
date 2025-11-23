import java.util.*;

class SORTracker {
    private PriorityQueue<Pair> maxHeap;
    private int index;

    public SORTracker() {
        maxHeap = new PriorityQueue<>((a, b) -> a.rank == b.rank ? a.name.compareTo(b.name) : b.rank - a.rank);
        index = 0;
    }

    public void add(String name, int score) {
        maxHeap.offer(new Pair(name, score));
    }

    public String get() {
        index++;
        List<Pair> tempList = new ArrayList<>();
        Pair result = null;

        while (!maxHeap.isEmpty() && index > 0) {
            result = maxHeap.poll();
            tempList.add(result);
            index--;
        }

        for (Pair p : tempList) {
            maxHeap.offer(p);
        }

        return result.name;
    }

    private static class Pair {
        String name;
        int rank;

        Pair(String name, int rank) {
            this.name = name;
            this.rank = rank;
        }
    }
}