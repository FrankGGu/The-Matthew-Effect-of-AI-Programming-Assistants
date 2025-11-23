import java.util.TreeSet;

class SmallestInfiniteSet {

    private TreeSet<Integer> added;
    private int current;

    public SmallestInfiniteSet() {
        added = new TreeSet<>();
        current = 1;
    }

    public int popSmallest() {
        if (!added.isEmpty() && added.first() < current) {
            return added.pollFirst();
        } else {
            return current++;
        }
    }

    public void addBack(int num) {
        if (num < current) {
            added.add(num);
        }
    }
}