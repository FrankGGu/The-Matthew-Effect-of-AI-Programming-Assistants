import java.util.TreeSet;

class SmallestInfiniteSet {
    private TreeSet<Integer> addedBackSet;
    private int currentSmallest;

    public SmallestInfiniteSet() {
        addedBackSet = new TreeSet<>();
        currentSmallest = 1;
    }

    public int popSmallest() {
        if (!addedBackSet.isEmpty()) {
            return addedBackSet.pollFirst();
        }
        int result = currentSmallest;
        currentSmallest++;
        return result;
    }

    public void addBack(int num) {
        if (num < currentSmallest) {
            addedBackSet.add(num);
        }
    }
}