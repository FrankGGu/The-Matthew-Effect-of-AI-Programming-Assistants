import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.Set;

class RandomizedCollection {

    private List<Integer> list;
    private Map<Integer, Set<Integer>> valToIndices;
    private Random rand;

    public RandomizedCollection() {
        list = new ArrayList<>();
        valToIndices = new HashMap<>();
        rand = new Random();
    }

    public boolean insert(int val) {
        boolean containsVal = valToIndices.containsKey(val);

        if (!containsVal) {
            valToIndices.put(val, new HashSet<>());
        }

        valToIndices.get(val).add(list.size());
        list.add(val);

        return !containsVal;
    }

    public boolean remove(int val) {
        if (!valToIndices.containsKey(val) || valToIndices.get(val).isEmpty()) {
            return false;
        }

        Set<Integer> indices = valToIndices.get(val);
        int idxToRemove = indices.iterator().next(); 

        int lastElementIdx = list.size() - 1;
        int lastElementVal = list.get(lastElementIdx);

        if (idxToRemove != lastElementIdx) {
            list.set(idxToRemove, lastElementVal);

            valToIndices.get(lastElementVal).remove(lastElementIdx);
            valToIndices.get(lastElementVal).add(idxToRemove);
        }

        indices.remove(idxToRemove);

        list.remove(lastElementIdx);

        if (indices.isEmpty()) {
            valToIndices.remove(val);
        }

        return true;
    }

    public int getRandom() {
        return list.get(rand.nextInt(list.size()));
    }
}