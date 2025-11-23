public class Solution {

import java.util.*;

public class NumberContainers {
    private Map<Integer, Integer> indexToNumber;
    private Map<Integer, TreeSet<Integer>> numberToIndices;

    public NumberContainers() {
        indexToNumber = new HashMap<>();
        numberToIndices = new HashMap<>();
    }

    public void assign(int index, int number) {
        if (indexToNumber.containsKey(index)) {
            int oldNumber = indexToNumber.get(index);
            if (oldNumber != number) {
                numberToIndices.get(oldNumber).remove(index);
                if (numberToIndices.get(oldNumber).isEmpty()) {
                    numberToIndices.remove(oldNumber);
                }
            }
        }
        indexToNumber.put(index, number);
        numberToIndices.putIfAbsent(number, new TreeSet<>());
        numberToIndices.get(number).add(index);
    }

    public void unassign(int index) {
        if (indexToNumber.containsKey(index)) {
            int number = indexToNumber.get(index);
            numberToIndices.get(number).remove(index);
            if (numberToIndices.get(number).isEmpty()) {
                numberToIndices.remove(number);
            }
            indexToNumber.remove(index);
        }
    }

    public int[] getNumbers() {
        Set<Integer> numbers = new HashSet<>(numberToIndices.keySet());
        int[] result = new int[numbers.size()];
        int i = 0;
        for (int num : numbers) {
            result[i++] = num;
        }
        Arrays.sort(result);
        return result;
    }

    public int[] getIndices(int number) {
        if (!numberToIndices.containsKey(number)) {
            return new int[0];
        }
        int size = numberToIndices.get(number).size();
        int[] result = new int[size];
        int i = 0;
        for (int index : numberToIndices.get(number)) {
            result[i++] = index;
        }
        Arrays.sort(result);
        return result;
    }
}
}