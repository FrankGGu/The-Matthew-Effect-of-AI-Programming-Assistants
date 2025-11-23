class SnapshotArray {
public:
    vector<unordered_map<int, int>> snaps;
    int snap_id;

    SnapshotArray(int length) {
        snaps.resize(length);
        snap_id = 0;
    }

    void set(int index, int val) {
        snaps[index][snap_id] = val;
    }

    int snap() {
        return snap_id++;
    }

    int get(int index, int snap_id) {
        auto it = snaps[index].upper_bound(snap_id);
        return it == snaps[index].begin() ? 0 : prev(it)->second;
    }
};