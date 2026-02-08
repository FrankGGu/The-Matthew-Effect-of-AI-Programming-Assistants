import java.util.*;

class NumberContainers {

    private Map<Integer, Integer> numberToIdx;
    private Map<Integer, TreeSet<Integer>> idxToNumbers;

    public NumberContainers() {
        numberToIdx = new HashMap<>();
        idxToNumbers = new HashMap<>();
    }

    public void change(int index, int number) {
        if (numberToIdx.containsKey(index)) {
            int oldNumber = numberToIdx.get(index);
            idxToNumbers.get(oldNumber).remove(index);
            if (idxToNumbers.get(oldNumber).isEmpty()) {
                idxToNumbers.remove(oldNumber);
            }
        }

        numberToIdx.put(index, number);
        idxToNumbers.computeIfAbsent(number, k -> new TreeSet<>()).add(index);
    }

    public int find(int number) {
        if (!idxToNumbers.containsKey(number)) {
            return -1;
        }
        return idxToNumbers.get(number).first();
    }
}