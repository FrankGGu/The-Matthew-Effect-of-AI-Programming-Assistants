class SnapshotArray {
    private int snapId = 0;
    private List<TreeMap<Integer, Integer>> arr;
    private int length;

    public SnapshotArray(int length) {
        this.length = length;
        arr = new ArrayList<>(length);
        for (int i = 0; i < length; i++) {
            arr.add(new TreeMap<>());
            arr.get(i).put(0, 0);
        }
    }

    public void set(int index, int val) {
        arr.get(index).put(snapId, val);
    }

    public int snap() {
        return snapId++;
    }

    public int get(int index, int snap_id) {
        return arr.get(index).floorEntry(snap_id).getValue();
    }
}