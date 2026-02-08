public class Solution {

import java.util.*;

public class SnapshotArray {
    private int[] arr;
    private Map<Integer, Integer> map;
    private int snapId;

    public SnapshotArray(int length) {
        arr = new int[length];
        map = new HashMap<>();
        snapId = 0;
    }

    public void set(int index, int val) {
        map.put(index, val);
    }

    public int snap() {
        int currentSnapId = snapId;
        snapId++;
        return currentSnapId;
    }

    public int get(int index, int snapId) {
        if (map.containsKey(index)) {
            return map.get(index);
        }
        return 0;
    }
}
}