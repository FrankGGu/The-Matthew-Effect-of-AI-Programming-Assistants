import java.util.ArrayList;
import java.util.List;
import java.util.TreeMap;

class SnapshotArray {
    private List<TreeMap<Integer, Integer>> snaps;
    private int snapId;

    public SnapshotArray(int length) {
        snaps = new ArrayList<>();
        for (int i = 0; i < length; i++) {
            snaps.add(new TreeMap<>());
            snaps.get(i).put(0, 0);
        }
        snapId = 0;
    }

    public void set(int index, int val) {
        snaps.get(index).put(snapId, val);
    }

    public int snap() {
        return snapId++;
    }

    public int get(int index, int snap_id) {
        return snaps.get(index).floorEntry(snap_id).getValue();
    }
}