class SnapshotArray {
    private int[][] snapshots;
    private int snapId;
    private int length;

    public SnapshotArray(int length) {
        this.length = length;
        snapshots = new int[10000][length];
        snapId = 0;
    }

    public void set(int index, int val) {
        snapshots[snapId][index] = val;
    }

    public int snap() {
        return snapId++;
    }

    public int get(int index, int snap_id) {
        return snapshots[snap_id][index];
    }
}