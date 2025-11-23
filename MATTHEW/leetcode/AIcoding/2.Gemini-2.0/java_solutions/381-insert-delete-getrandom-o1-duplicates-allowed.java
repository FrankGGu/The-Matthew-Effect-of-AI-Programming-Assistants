import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Random;

class RandomizedCollection {

    private List<Integer> list;
    private HashMap<Integer, List<Integer>> map;
    private Random random;

    public RandomizedCollection() {
        list = new ArrayList<>();
        map = new HashMap<>();
        random = new Random();
    }

    public boolean insert(int val) {
        list.add(val);
        if (!map.containsKey(val)) {
            map.put(val, new ArrayList<>());
        }
        map.get(val).add(list.size() - 1);
        return map.get(val).size() == 1;
    }

    public boolean remove(int val) {
        if (!map.containsKey(val) || map.get(val).isEmpty()) {
            return false;
        }

        int indexToRemove = map.get(val).remove(map.get(val).size() - 1);
        int lastIndex = list.size() - 1;

        if (indexToRemove != lastIndex) {
            int lastVal = list.get(lastIndex);
            list.set(indexToRemove, lastVal);

            List<Integer> lastValIndices = map.get(lastVal);
            lastValIndices.remove(Integer.valueOf(lastIndex));
            lastValIndices.add(indexToRemove);
            map.put(lastVal, lastValIndices);

        }

        list.remove(lastIndex);
        if (map.get(val).isEmpty()) {
            map.remove(val);
        }
        return true;
    }

    public int getRandom() {
        return list.get(random.nextInt(list.size()));
    }
}