import java.util.HashMap;
import java.util.TreeSet;

class NumberContainers {

    private HashMap<Integer, Integer> indexToNumber;
    private HashMap<Integer, TreeSet<Integer>> numberToIndices;

    public NumberContainers() {
        indexToNumber = new HashMap<>();
        numberToIndices = new HashMap<>();
    }

    public void change(int index, int number) {
        if (indexToNumber.containsKey(index)) {
            int oldNumber = indexToNumber.get(index);
            TreeSet<Integer> oldIndices = numberToIndices.get(oldNumber);
            if (oldIndices != null) {
                oldIndices.remove(index);
                if (oldIndices.isEmpty()) {
                    numberToIndices.remove(oldNumber);
                }
            }
        }

        indexToNumber.put(index, number);
        numberToIndices.computeIfAbsent(number, k -> new TreeSet<>()).add(index);
    }

    public int find(int number) {
        TreeSet<Integer> indices = numberToIndices.get(number);
        if (indices == null || indices.isEmpty()) {
            return -1;
        } else {
            return indices.first();
        }
    }
}