import java.util.*;

class NumberContainers {
    private Map<Integer, Integer> numToIndex;
    private Map<Integer, TreeSet<Integer>> indexToNum;
    private int index;

    public NumberContainers() {
        numToIndex = new HashMap<>();
        indexToNum = new HashMap<>();
        index = 0;
    }

    public void change(int number, int container) {
        if (numToIndex.containsKey(number)) {
            int oldContainer = numToIndex.get(number);
            indexToNum.get(oldContainer).remove(number);
            if (indexToNum.get(oldContainer).isEmpty()) {
                indexToNum.remove(oldContainer);
            }
        }
        numToIndex.put(number, container);
        indexToNum.putIfAbsent(container, new TreeSet<>());
        indexToNum.get(container).add(number);
    }

    public int find(int number) {
        return numToIndex.getOrDefault(number, 0);
    }

    public int findFirst() {
        if (indexToNum.isEmpty()) return 0;
        for (int container : indexToNum.keySet()) {
            if (!indexToNum.get(container).isEmpty()) {
                return container;
            }
        }
        return 0;
    }
}