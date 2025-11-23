import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

class RandomizedSet {
    private List<Integer> list;
    private Map<Integer, Integer> valToIndex;
    private Random rand;

    public RandomizedSet() {
        list = new ArrayList<>();
        valToIndex = new HashMap<>();
        rand = new Random();
    }

    public boolean insert(int val) {
        if (valToIndex.containsKey(val)) {
            return false;
        }
        list.add(val);
        valToIndex.put(val, list.size() - 1);
        return true;
    }

    public boolean remove(int val) {
        if (!valToIndex.containsKey(val)) {
            return false;
        }

        int indexToRemove = valToIndex.get(val);
        int lastElement = list.get(list.size() - 1);

        if (indexToRemove != list.size() - 1) {
            list.set(indexToRemove, lastElement);
            valToIndex.put(lastElement, indexToRemove);
        }

        list.remove(list.size() - 1);
        valToIndex.remove(val);
        return true;
    }

    public int getRandom() {
        return list.get(rand.nextInt(list.size()));
    }
}