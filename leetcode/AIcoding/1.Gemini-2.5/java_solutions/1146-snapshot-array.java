import java.util.ArrayList;
import java.util.List;
import java.util.TreeMap;

class SnapshotArray {

    private List<TreeMap<Integer, Integer>> history;
    private int snapId;

    public SnapshotArray(int length) {
        history = new ArrayList<>(length);
        for (int i = 0; i < length; i++) {
            TreeMap<Integer, Integer> map = new TreeMap<>();
            map.put(0, 0); // Initialize all elements to 0 at snap_id 0
            history.add(map);
        }
        snapId = 0;
    }

    public void set(int index, int val) {
        history.get(index).put(snapId, val);
    }

    public int snap() {
        return snapId++;
    }

    public int get(int index, int snap_id) {
        return history.get(index).floorEntry(snap_id).getValue();
    }
}